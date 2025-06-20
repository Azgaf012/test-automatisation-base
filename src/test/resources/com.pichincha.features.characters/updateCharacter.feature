  # src/test/resources/com/pichincha/features/characters/updateCharacter.feature
  @REQ_MC_API_005
  @HU_MC_API_005
  @descripcion("update_existing_character")
  @marvel_characters_api
  Feature: Update an existing character

    Background:
      * url port_characters
      * configure headers = { 'Content-Type': 'application/json' }

    Scenario: T-API-MC_API_005-UC01-Update Spider-Man with new description and power → 200 OK
      * def updatePayload =
        """
        {
          "name": "Spider-Man",
          "alterego": "Peter Parker",
          "description": "Protector amistoso de Nueva York, más fuerte que nunca.",
          "powers": [
            "Super fuerza",
            "Agilidad sobrehumana",
            "Sentido arácnido",
            "Trepar muros",
            "Regeneración"
          ]
        }
        """
      Given path 'zuniga.andree', 'api', 'characters', 3
      And request updatePayload
      When method put
      Then status 200
      And match response.id == 3
      And match response.name == updatePayload.name
      And match response.alterego == updatePayload.alterego
      And match response.description == updatePayload.description
      And match each response.powers[*] == '#string'
      # Verificar que la nueva potencia "Regeneración" está presente
      And match response.powers contains 'Regeneración'

    Scenario: T-API-MC_API_005-UC02-Update non-existent character → 404 Not Found
      * def updatePayload =
        """
        {
          "name": "Spider-Man",
          "alterego": "Peter Parker",
          "description": "Protector amistoso de Nueva York, más fuerte que nunca.",
          "powers": [
            "Super fuerza",
            "Agilidad sobrehumana",
            "Sentido arácnido",
            "Trepar muros",
            "Regeneración"
          ]
        }
        """
      Given path 'zuniga.andree', 'api', 'characters', 999999
      And request updatePayload
      When method put
      Then status 404
      And match response.error == 'Character not found'
