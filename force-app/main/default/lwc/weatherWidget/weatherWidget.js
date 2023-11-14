import { LightningElement, api, track, wire } from 'lwc';
import getWeatherByCity from '@salesforce/apex/WeatherInfo.getWeatherByCity';
import IMAGES from "@salesforce/resourceUrl/WeatherWidgetImages";

export default class WeatherWidget extends LightningElement {
    @track city;
    @track cityInput;
    @track weather;
    @track weatherImage;
    @track temperature;
    @track hummidity;
    @track wind;
    @track isFormEnabled = false;
    @track isError;

    connectedCallback(){
        this.getWeather();
    }

    getWeather(){
        getWeatherByCity({city: this.cityInput})
            .then(res => {
                this.city = res.name;
                this.weather = res.weather[0].main;
                this.temperature = Math.round(res.main.temp);
                this.weatherImage = IMAGES + '/' + this.weather + '.png';
                this.hummidity = res.main.humidity;
                this.wind = res.wind.speed;
                this.isError=false;
            })
            .catch(error => {
                this.isError=true;
                this.weatherImage = IMAGES + '/404.png';
                console.log(error);
                console.log('error')
            })
    }

    handleCityInputChange(event){
        this.cityInput = event.target.value;
    }

    handleEdit(){
        this.isFormEnabled = true;
    }

    handleSave(){
        this.getWeather();
        this.isFormEnabled = false;
    }

    handleCancel(){
        this.isFormEnabled = false;
    }
}