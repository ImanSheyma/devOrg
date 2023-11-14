@isTest
public with sharing class WeatherInfoTest {
    @isTest static void getWeatherByCityTest(){
        Test.setMock(HttpCalloutMock.class, new WeatherApiMockHttpResponseGenerator());
        WeatherWrapper w = WeatherInfo.getWeatherByCity('Minsk');
        System.assert(w.name == 'Minsk');
    }
}