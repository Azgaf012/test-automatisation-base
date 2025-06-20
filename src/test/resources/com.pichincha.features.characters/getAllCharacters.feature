@REQ_MC_API_001
@HU_MC_API_001
@descripcion("get_all_characters")
@marvel_characters_api
@agente2
@E2
@iniciativa_marvel_characters_api
Feature: Get all characters

  Background:
    * url port_characters
    * configure headers = { 'Content-Type': 'application/json' }

  @id:GA01 @get_success @status_200
  Scenario: T-API-MC_API_001-GA01-Get all characters 200 - karate
    Given path 'zuniga.andree', 'api', 'characters'
    When method get
    Then status 200
    And match each response[*].id == '#number'
    And match each response[*].name == '#string'
    And match each response[*].alterego == '#string'
    And match each response[*].description == '#string'
    And match each response[*].powers[*] == '#string'

  @id:GA02 @empty_username_error @status_500
  Scenario: T-API-MC_API_001-GA02-Get all characters empty username 500 - karate
    Given path '', 'api', 'characters'
    When method get
    Then status 500
    And match response.error == 'Internal server error'
