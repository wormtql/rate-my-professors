<template lang="pug">
    div(:style="rootStyle", :title="tooltip")
        svg(width="100%", height="100%")
            circle(:style="circleStyle")
            circle(:style="circle2Style")
        span(:style="textStyle") {{ this.text }}
</template>

<script>
    export default {
        name: "Idk",
        props: {
            frac: {
                type: Number,
                default: 0.75
            },
            color: {
                type: String,
                default: "#00b0ff"
            },
            tooltip: {
                type: String,
                default: "tooltip"
            },
            text: {
                type: String,
                default: "75%"
            },
            textColor: {
                type: String,
                default: "black"
            },
            size: {
                type: Number,
                default: 96,
            },
            strokeWidth: {
                type: Number,
                default: 8
            }
        },
        computed: {
            radius: function () {
                return this.size / 2 - this.strokeWidth / 2;
            },
            perimeter: function () {
                return this.radius * Math.PI * 2;
            },
            rootStyle: function () {
                return {
                    display: "inline-block",
                    width: `${this.size}px`,
                    height: `${this.size}px`,
                    // background: "#00000011",
                    position: "relative",
                }
            },
            circleStyle: function () {
                return {
                    stroke: this.color,
                    cx: `${this.size / 2}px`,
                    cy: `${this.size / 2}px`,
                    r: `${this.radius}px`,
                    strokeWidth: `${this.strokeWidth}px`,
                    fill: "none",
                    strokeLinecap: "round",
                    strokeDasharray: this.frac >= 0.25 ?
                        `${this.perimeter * (this.frac - 0.25)} ${this.perimeter * (1 - this.frac)} ${this.perimeter / 4}` :
                        `${this.perimeter} ${this.perimeter * 0.75} ${this.perimeter * this.frac} ${this.perimeter * (0.25 - this.frac)}`,
                    strokeDashoffset: this.frac >= 0.25 ? "0" : `${this.perimeter}`,
                    zIndex: "100"
                }
            },
            circle2Style: function () {
                return {
                    stroke: "#00000009",
                    cx: `${this.size / 2}px`,
                    cy: `${this.size / 2}px`,
                    r: `${this.radius}px`,
                    strokeWidth: `${this.strokeWidth}px`,
                    fill: "none",
                    // strokeLinecap: "round",
                }
            },
            textStyle: function () {
                return {
                    position: "absolute",
                    left: "50%",
                    top: "50%",
                    transform: "translate(-50%, -50%)",
                    color: this.textColor,
                }
            }
        }
    }
</script>

<style scoped>
    /*svg {*/
    /*    width: 100%;*/
    /*    height: 100%;*/
    /*}*/
</style>