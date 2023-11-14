public class WeatherWrapper {
    @AuraEnabled
    public Weather[] weather;
    @AuraEnabled
    public Main main;
    @AuraEnabled
    public Wind wind;
    @AuraEnabled
    public String name;
    class Weather{
        @AuraEnabled
        public String main;
    }
    class Main{
        @AuraEnabled
        public Decimal temp;
        @AuraEnabled
        public Integer pressure;
        @AuraEnabled
        public Integer humidity;
    }
    class Wind{
        @AuraEnabled
        public Decimal speed;
    }

    public static WeatherWrapper parse(String json){
        return (WeatherWrapper) System.JSON.deserialize(json, WeatherWrapper.class);
    }
}