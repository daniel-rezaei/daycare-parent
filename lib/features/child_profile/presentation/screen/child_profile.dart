import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/phone_utils.dart';
import '../../../../resorces/pallete.dart';
import '../bloc/child_schedule_bloc.dart';
import '../bloc/child_schedule_event.dart';
import '../bloc/child_schedule_state.dart';
import '../bloc/health_bloc.dart';
import '../bloc/health_event.dart';
import '../bloc/health_state.dart';
import '../bloc/guardian_bloc.dart';
import '../bloc/emergency_contacts_bloc.dart';
import '../bloc/pick_up_bloc.dart';
import '../widgets/category_item.dart';
import '../widgets/emergency_setion.dart';
import '../widgets/emergency_item_widgets.dart';
import '../widgets/auth_tag_item.dart';
import '../widgets/item_allergy.dart';
import '../widgets/role_contact_widgets.dart';
import '../bloc/guardian_state.dart';
import '../bloc/emergency_contacts_state.dart';
import '../bloc/pick_up_state.dart';
import '../bloc/guardian_event.dart';
import '../bloc/emergency_contact_event.dart';
import '../bloc/picke_up_event.dart';

class ChildProfileWidget extends StatefulWidget {
  const ChildProfileWidget({
    super.key,
    required this.childId,
    required this.name,
    this.dob,
    this.photoUrl,
  });

  final String name;
  final DateTime? dob;
  final String? photoUrl;
  final String? childId;

  @override
  _ChildProfileWidgetState createState() => _ChildProfileWidgetState();
}

class _ChildProfileWidgetState extends State<ChildProfileWidget> {
  @override
  void initState() {
    super.initState();
    _fetchChildData();
  }

  void _fetchChildData() {
    final id = widget.childId ?? "";

    context.read<GuardianBloc>().add(LoadPrimaryGuardians(childId: id));
    context.read<EmergencyContactsBloc>().add(LoadEmergencyContacts(id));
    context.read<PickupBloc>().add(LoadAuthorizedPickups(id));
    context.read<HealthBloc>().add(LoadHealthCounts(id));
    context.read<ChildScheduleBloc>().add(LoadChildSchedule(widget.childId!));
  }

  String formatDate(DateTime? date) {
    if (date == null) return '-';
    return DateFormat('MMMM d, yyyy').format(date);
  }

  bool _isLoading(BuildContext context) {
    final g = context.watch<GuardianBloc>().state;
    final e = context.watch<EmergencyContactsBloc>().state;
    final p = context.watch<PickupBloc>().state;
    final h = context.watch<HealthBloc>().state;
    final s = context.watch<ChildScheduleBloc>().state;

    return g is GuardianLoading ||
        e is EmergencyContactsLoading ||
        p is PickupLoading ||
        h is HealthLoading ||
        s is ChildScheduleLoading;
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = _isLoading(context);
    final cardSpacing = 10.0;

    if (isLoading) {
      // نمایش لودینگ وسط صفحه با گرادیان بک‌گراند
      return Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE9DFFF), Color(0xFFF3EFFF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          const Center(
            child: CircularProgressIndicator(color: Colors.purpleAccent),
          ),
        ],
      );
    }

    // وقتی همه داده‌ها آماده شدند، کل صفحه نمایش داده می‌شود
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE9DFFF), Color(0xFFF3EFFF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_sharp, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              "Child Profile",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            centerTitle: false,
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Palette.bgBackground90,
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: BlocBuilder<ChildScheduleBloc, ChildScheduleState>(
                  builder: (context, state) {
                    if (state is ChildScheduleLoaded && state.events.isNotEmpty) {
                      return Row(
                        children: [
                          SvgPicture.asset('assets/images/ic_schedule.svg'),
                          const SizedBox(width: 4),
                          Text(
                            state.events.first.scheduleType ?? '-',
                            style: const TextStyle(
                              color: Palette.textForeground,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      );
                    }
                    return const Text("-");
                  },
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // -----------------------
                // Child Header
                // -----------------------
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: (widget.photoUrl != null && widget.photoUrl!.isNotEmpty)
                            ? (widget.photoUrl!.startsWith('http')
                            ? CachedNetworkImageProvider( widget.photoUrl!,)
                            : AssetImage(widget.photoUrl!) as ImageProvider)
                            : null,
                        child: (widget.photoUrl == null || widget.photoUrl!.isEmpty)
                            ? const Icon(Icons.person, size: 40, color: Colors.grey)
                            : null,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black87),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Palette.bgBackground90,
                              border: Border.all(color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset('assets/images/ic_gifts.svg'),
                                const SizedBox(width: 6),
                                const Text('Date of Birth', style: TextStyle(fontSize: 13)),
                                const SizedBox(width: 6),
                                Container(width: 1, height: 18, color: Palette.bgColorDivider),
                                const SizedBox(width: 6),
                                Text(formatDate(widget.dob),
                                    style: const TextStyle(fontSize: 13, color: Palette.txtPrimary)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // -----------------------
                // Guardians Section
                // -----------------------
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final availableWidth = constraints.maxWidth;
                            final cardWidth = (availableWidth - cardSpacing) / 2;

                            return BlocBuilder<GuardianBloc, GuardianState>(
                              builder: (context, state) {
                                final guardians =
                                state is GuardianLoaded ? state.guardians : [];
                                return Row(
                                  children: List.generate(2, (index) {
                                    if (index < guardians.length) {
                                      final g = guardians[index];
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            right: index == guardians.length - 1 ? 0 : cardSpacing),
                                        child: SizedBox(
                                          width: cardWidth,
                                          child: ContactCard(
                                            name: "${g.firstName ?? ''} ${g.lastName ?? ''}",
                                            role: g.relation,
                                            phone: PhoneUtils.formatPhoneNumber(g.phone),
                                            photo: g.photo,
                                            color: g.relation.toLowerCase() == 'mother'
                                                ? Palette.borderPrimary20
                                                : Palette.backgroundBgBlue,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return SizedBox(
                                        width: cardWidth,
                                        child: Container(
                                          height: 100,
                                          color: Palette.bgBackground90,
                                          child: const Center(child: Text("No Guardian")),
                                        ),
                                      );
                                    }
                                  }),
                                );
                              },
                            );
                          },
                        ),

                        const SizedBox(height: 20),

                        // Emergency Contacts Section
                        BlocBuilder<EmergencyContactsBloc, EmergencyContactsState>(
                          builder: (context, state) {
                            final contacts =
                            state is EmergencyContactsLoaded ? state.contacts : [];
                            final isCollapsed =
                            state is EmergencyContactsLoaded ? state.isCollapsed : false;

                            return
                              SectionEmergency(
                                title: "Emergency Contacts",
                                count: contacts.length,
                                icon: 'assets/images/ic_emergency.svg',
                                isCollapsed: isCollapsed,
                                onTitleTap: () {
                                  context.read<EmergencyContactsBloc>().add(ToggleEmergencyCollapse());
                                },
                                items: contacts.map(
                                      (c) => EmergencyItem(
                                    name: c.name,
                                    phone: c.phone,
                                    color: Palette.backgroundBgPink,
                                  ),
                                ).toList(),
                              );

                          },
                        ),

                        const SizedBox(height: 14),

                        // Authorized Pickup Section
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text('Authorized Pick-up',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                        BlocBuilder<PickupBloc, PickupState>(
                          builder: (context, state) {
                            final pickups = state is PickupLoaded ? state.pickups : [];

                            if (pickups.isEmpty) {
                              return const Text("No authorized pick-ups");
                            }

                            final Map<String, dynamic> dedupedPickups = {};
                            for (var p in pickups) {
                              if (p.contactId != null) {
                                if (!dedupedPickups.containsKey(p.contactId)) {
                                  dedupedPickups[p.contactId!] = p;
                                }
                              } else {
                                final tempKey = '${p.name}_${p.role}_${p.oneTime ?? false}';
                                dedupedPickups[tempKey] ??= p;
                              }
                            }

                            final displayPickups = dedupedPickups.values.toList();

                            return
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: displayPickups.map((p) => Padding(
                                    padding: const EdgeInsets.only(right: 12), // فاصله بین آیتم‌ها
                                    child: TagItem(
                                      name: p.name,
                                      subtitle: p.role,
                                    ),
                                  )).toList(),
                                ),
                              );

                          },
                        ),

                        const SizedBox(height: 16),

                        // Health Section
                        BlocBuilder<HealthBloc, HealthState>(
                          builder: (context, state) {
                            final counts = state is HealthLoaded ? state.counts : {};
                            final lists = state is HealthLoaded ? state.lists : {};

                            Widget buildCategory({
                              required String key,
                              required String title,
                              required String icon,
                              required String Function(dynamic) getName,
                            }) {
                              final count = counts[key] ?? 0;
                              final items = lists[key];

                              return CategoryItem(
                                icon: icon,
                                title: title,
                                count: count > 0 ? "#$count Items" : "# No Items",
                                children: (items != null)
                                    ? items.map<Widget>((e) {
                                  final label = getName(e);
                                  return ListItem(text: label);
                                }).toList()
                                    : const [],
                                onExpand: () {
                                  if (lists[key] == null) {
                                    context.read<HealthBloc>().add(
                                      LoadHealthList(childId: widget.childId ?? '', key: key),
                                    );
                                  }
                                },
                              );
                            }

                            // توابع getName برای Health
                            String fromAllergy(dynamic e) {
                              try {
                                if (e is Map) return (e['allergen_name'] ?? e['allergenName'] ?? e['name'] ?? '').toString();
                                return (e as dynamic).allergenName?.toString() ?? '';
                              } catch (_) { return e.toString(); }
                            }

                            String fromDietary(dynamic e) {
                              try {
                                if (e is Map) return (e['restriction_name'] ?? e['restrictionName'] ?? e['name'] ?? '').toString();
                                return (e as dynamic).restrictionName?.toString() ?? '';
                              } catch (_) { return e.toString(); }
                            }

                            String fromMedication(dynamic e) {
                              try {
                                if (e is Map) return (e['medication_name'] ?? e['medicationName'] ?? '').toString();
                                return (e as dynamic).medicationName?.toString() ?? '';
                              } catch (_) { return e.toString(); }
                            }

                            String fromImmunization(dynamic e) {
                              try {
                                if (e is Map) return (e['VaccineName'] ?? e['vaccineName'] ?? '').toString();
                                return (e as dynamic).vaccineName?.toString() ?? '';
                              } catch (_) { return e.toString(); }
                            }

                            String fromPhysical(dynamic e) {
                              try {
                                if (e is Map) return (e['requirement_name'] ?? e['requirementName'] ?? '').toString();
                                return (e as dynamic).requirementName?.toString() ?? '';
                              } catch (_) { return e.toString(); }
                            }

                            String fromDisease(dynamic e) {
                              try {
                                if (e is Map) return (e['disease_name'] ?? e['diseaseName'] ?? '').toString();
                                return (e as dynamic).diseaseName?.toString() ?? '';
                              } catch (_) { return e.toString(); }
                            }

                            return Column(
                              children: [
                                buildCategory(key: "allergies", title: "Allergy", icon: 'assets/images/ic_allergy.svg', getName: fromAllergy),
                                const SizedBox(height: 12),
                                buildCategory(key: "dietary", title: "Dietary Restrictions", icon: 'assets/images/ic_dietary_restrictions.svg', getName: fromDietary),
                                const SizedBox(height: 12),
                                buildCategory(key: "medication", title: "Medication", icon: 'assets/images/ic_medication.svg', getName: fromMedication),
                                const SizedBox(height: 12),
                                buildCategory(key: "immunization", title: "Immunization", icon: 'assets/images/ic_immunization.svg', getName: fromImmunization),
                                const SizedBox(height: 12),
                                buildCategory(key: "physical", title: "Physical Requirements", icon: 'assets/images/ic_pysical_requirment.svg', getName: fromPhysical),
                                const SizedBox(height: 12),
                                buildCategory(key: "diseases", title: "Reportable Diseases", icon: 'assets/images/ic_disease.svg', getName: fromDisease),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


