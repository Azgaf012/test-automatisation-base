function fn() {
    var config = {};
    config.baseUrl = 'http://bp-se-test-cabcd9b246a5.herokuapp.com';
    config.port_characters = config.baseUrl;
    karate.configure('connectTimeout', 60000);
    karate.configure('readTimeout', 60000);
    return config;
}