@REQ_MC_API_003
@HU_MC_API_003
@descripcion("create_new_character")
@marvel_characters_api
@agente2
@E2
@iniciativa_marvel_characters_api
Feature: Create a new character

  Background:
    * url port_characters
    * configure headers = { 'Content-Type': 'application/json' }

  @id:CA01 @create_success @status_201
  Scenario: T-API-MC_API_003-CA01-Create character successfully 201 - karate
    * def requestPayload = read('classpath:data/marvel_characters_api/createCharacter.json')
    Given path 'zuniga.andree', 'api', 'characters'
    And request requestPayload
    When method post
    Then status 201
    And match response.id == '#number'
    And match response.name == requestPayload.name
    And match response.alterego == requestPayload.alterego
    And match response.description == requestPayload.description
    And match each response.powers[*] == '#string'

  @id:CA02 @duplicate_error @status_400
  Scenario: T-API-MC_API_003-CA02-Error on duplicate character 400 - karate
    * def duplicatePayload = read('classpath:data/marvel_characters_api/duplicateCharacter.json')
    Given path 'zuniga.andree', 'api', 'characters'
    And request duplicatePayload
    When method post
    Then status 400
    And match response.error == 'Character name already exists'

  @id:CA03 @validation_error @status_400
  Scenario: T-API-MC_API_003-CA03-Error on missing fields 400 - karate
    * def invalidPayload = read('classpath:data/marvel_characters_api/invalidCharacter.json')
    Given path 'zuniga.andree', 'api', 'characters'
    And request invalidPayload
    When method post
    Then status 400
    And match response.name == 'Name is required'
    And match response.alterego == 'Alterego is required'
    And match response.description == 'Description is required'
    And match response.powers == 'Powers are required'