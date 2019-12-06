<template lang="pug">
    -
        let svgStyle = `
            width: 100%;
            height: 100%;
        `

    div(:style="rootStyle")
        svg(style=svgStyle)
            circle(:style="circleStyle", :r="radius1", stroke-dasharray="60", class="circle1")
            circle(:style="circleStyle", :r="radius2", stroke-dasharray="40", class="circle2")
            circle(:style="circleStyle", :r="radius3", stroke-dasharray="15", class="circle3")
</template>

<script>
    export default {
        name: "LoadingBox",
        props: {
            size: {
                type: Number,
                default: 36
            },
            strokeWidth: {
                type: Number,
                default: 4
            },
            spacing: {
                type: Number,
                default: 2
            },
            color: {
                type: String,
                default: "#8c74f6",
            }
        },
        computed: {
            radius1: function () {
                return this.size / 2 - this.strokeWidth / 2;
            },
            radius2: function () {
                return this.size / 2 - this.strokeWidth - this.spacing - this.strokeWidth / 2;
            },
            radius3: function () {
                return this.size / 2 - this.strokeWidth * 2 - this.spacing * 2 - this.strokeWidth / 2;
            },
            rootStyle: function () {
                return {
                    display: "inline-block",
                    width: `${this.size}px`,
                    height: `${this.size}px`
                }
            },
            circleStyle: function () {
                return {
                    cx: `${this.size / 2}`,
                    cy: `${this.size / 2}`,
                    strokeWidth: `${this.strokeWidth}`,
                    stroke: this.color,
                    fill: "none",
                    strokeLinecap: "round",
                    transformOrigin: `${this.size / 2}px ${this.size / 2}px`,
                    // animation: "anim 4s linear infinite"
                }
            }
        }
    }
</script>

<style scoped>
    @keyframes anim {
        0% {
            transform: rotateZ(0);
        }
        100% {
            transform: rotateZ(360deg);
        }
    }

    .circle1 {
        animation: anim 3s linear infinite;
    }

    .circle2 {
        animation: anim 2s linear infinite;
    }

    .circle3 {
        animation: anim 1s linear infinite;
    }

    /*circle {*/

    /*}*/
</style>