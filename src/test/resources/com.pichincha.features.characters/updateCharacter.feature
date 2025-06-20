@REQ_MC_API_005
@HU_MC_API_005
@descripcion("update_existing_character")
@marvel_characters_api
@agente2
@E2
@iniciativa_marvel_characters_api
Feature: Update an existing character

  Background:
    * url port_characters
    * configure headers = { 'Content-Type': 'application/json' }

  @id:UC01 @update_success @status_200
  Scenario: T-API-MC_API_005-UC01-Update Spider-Man with new description and power 200 - karate
    * def updatePayload = read('classpath:data/marvel_characters_api/updateSpiderMan.json')
    Given path 'zuniga.andree', 'api', 'characters', 3
    And request updatePayload
    When method put
    Then status 200
    And match response.id == 3
    And match response.name == updatePayload.name
    And match response.alterego == updatePayload.alterego
    And match response.description == updatePayload.description
    And match each response.powers[*] == '#string'
    And match response.powers contains 'Regeneración'

  @id:UC02 @not_found_error @status_404
  Scenario: T-API-MC_API_005-UC02-Update non-existent character 404 - karate
    * def updatePayload = read('classpath:data/marvel_characters_api/updateSpiderMan.json')
    Given path 'zuniga.andree', 'api', 'characters', 999999
    And request updatePayload
    When method put
    Then status 404
    And match response.error == 'Character not found'
