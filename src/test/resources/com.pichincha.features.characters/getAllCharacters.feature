@REQ_MC_API_001
@HU_MC_API_001
@descripcion("Obtener lista de todos los personajes")
@nombre_microservicio("Marvel Characters API")
Feature: Obtener todos los personajes de Marvel

  Background:
  * url port_characters
  * configure headers = { 'Content-Type': 'application/json' }

  Scenario: GET all characters → 200 OK y lista no vacía
  Given path 'zuniga.andree', 'api', 'characters'
  When method get
  Then status 200


  And match each response[*].id == '#number'
  And match each response[*].name == '#string'
  And match each response[*].alterego == '#string'
  And match each response[*].description == '#string'
  And match each response[*].powers[*] == '#string'


  Scenario: GET all characters con username vacío → 500 Internal Server Error
  Given path '', 'api', 'characters'
  When method get
  Then status 500
  And match response.error == 'Internal server error'

