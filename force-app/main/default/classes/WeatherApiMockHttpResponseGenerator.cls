@isTest
global class WeatherApiMockHttpResponseGenerator implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest req){
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody(
            '{"weather": [{"main": "Clouds"}],'+
            '"main": {"temp": 1.86,"pressure": 1004,"humidity": 91},'+
            '"wind": {"speed": 2.36},'+
            '"name": "Minsk"}');
        res.setStatusCode(200);
        return res;
    }
}