
String assetUrl(dynamic  id) {
  const baseUrl = "http://51.79.53.56:8055";
  const token = "1C1ROl_Te_A_sNZNO00O3k32OvRIPcSo";

  return "$baseUrl/assets/$id?access_token=$token";
}
