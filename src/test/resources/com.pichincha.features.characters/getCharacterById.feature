@REQ_MC_API_002
@HU_MC_API_002
@descripcion("Obtener un personaje por su ID")
@nombre_microservicio("Marvel Characters API")
Feature: Obtener personaje por ID

  Background:
  * url port_characters
  * configure headers = { 'Content-Type': 'application/json' }

  Scenario: GET character by valid ID → 200 OK
  Given path 'zuniga.andree', 'api', 'characters', 2
  When method get
  Then status 200
  And match response.id == 2
  And match response.name == 'Iron Man'
  And match response.alterego == 'Tony Stark'
  And match response.description == 'Genius billionaire'
  And match each response.powers[*] == '#string'

  Scenario: GET character by non-existent ID → 404 Not Found
  Given path 'zuniga.andree', 'api', 'characters', 999999
  When method get
  Then status 404
  And match response.error == 'Character not found'

  Scenario: GET character with empty ID → 500 Internal Server Error
  Given path 'zuniga.andree', 'api', 'characters', ''
  When method get
  Then status 500
  And match response.error == 'Internal server error'
