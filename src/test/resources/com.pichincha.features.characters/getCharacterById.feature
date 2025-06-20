@REQ_MC_API_002
@HU_MC_API_002
@descripcion("get_character_by_id")
@marvel_characters_api
@agente2
@E2
@iniciativa_marvel_characters_api
Feature: Get a character by ID

  Background:
    * url port_characters
    * configure headers = { 'Content-Type': 'application/json' }

  @id:CB01 @get_success @status_200
  Scenario: T-API-MC_API_002-CB01-Get existing character by ID 200 - karate
    Given path 'zuniga.andree', 'api', 'characters', 2
    When method get
    Then status 200
    And match response.id == 2
    And match response.name == 'Iron Man'
    And match response.alterego == 'Tony Stark'
    And match response.description == 'Genius billionaire'
    And match each response.powers[*] == '#string'

  @id:CB02 @not_found_error @status_404
  Scenario: T-API-MC_API_002-CB02-Get non-existent character by ID 404 - karate
    Given path 'zuniga.andree', 'api', 'characters', 999999
    When method get
    Then status 404
    And match response.error == 'Character not found'

  @id:CB03 @empty_id_error @status_500
  Scenario: T-API-MC_API_002-CB03-Get character with empty ID 500 - karate
    Given path 'zuniga.andree', 'api', 'characters', ''
    When method get
    Then status 500
    And match response.error == 'Internal server error'
