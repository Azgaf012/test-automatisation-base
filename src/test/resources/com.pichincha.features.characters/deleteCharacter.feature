@REQ_MC_API_004
@HU_MC_API_004
@descripcion("delete_last_created_character")
@marvel_characters_api
@agente2
@E2
@iniciativa_marvel_characters_api
Feature: Delete a character

  Background:
    * url port_characters
    * configure headers = { 'Content-Type': 'application/json' }

  @id:DC01 @delete_success @status_204
  Scenario: T-API-MC_API_004-DC01-Delete last created character → 204 No Content
    # 1) Get all characters
    Given path 'zuniga.andree', 'api', 'characters'
    When method get
    Then status 200

    # 2) Calculate last index and extract the ID
    * def count = karate.sizeOf(response)
    * def lastId = response[count - 1].id

    # 3) Delete that character
    Given path 'zuniga.andree', 'api', 'characters', lastId
    When method delete
    Then status 204

  @id:DC02 @not_found @status_404
  Scenario: T-API-MC_API_004-DC02-Delete non-existent character → 404 Not Found
    Given path 'zuniga.andree', 'api', 'characters', 999999
    When method delete
    Then status 404
    And match response.error == 'Character not found'
