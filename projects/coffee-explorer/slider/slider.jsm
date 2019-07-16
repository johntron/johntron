import loadStyle from '/load-style.jsm';
loadStyle('/slider/slider.css');

export default class Slider {
    constructor() {
        this.dom = document.createElement('div');
        this.dom.classList.add(this.constructor.name)
        this.value = 0.25;
        this.update();
    }

    get percentage() {
        debugger;
        return `${this.value * 100}%`;
    }

    update() {
        this.dom.style.marginRight = this.percentage;
    }
}
