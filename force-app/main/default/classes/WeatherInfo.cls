public with sharing class WeatherInfo {
    private static String apiKey = '4c2c21eb9ed4531df35727ae1cdeb0ad';
    private static String apiUrl = 'https://api.openweathermap.org/data/2.5/weather?' +
    'units=metric&q=';

    public class WeatherInfoException extends Exception {}

    @AuraEnabled(cacheable=true)
    public static WeatherWrapper getWeatherByCity(String city){
        try {
            String def = [SELECT City__c FROM WeatherWidgetConfig__mdt Limit 1].City__c;
            if(city == null) city = def;
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(apiUrl + city + '&appid=' + apiKey);
            request.setMethod('GET');
            HttpResponse response = http.send(request);
            response.getStatus();

            if(response.getStatusCode()==401)
                throw new WeatherInfoException('Invalis API Key');
            if(response.getStatusCode()==404)
                throw new WeatherInfoException('City Not Found');

            return WeatherWrapper.parse(response.getBody());
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}