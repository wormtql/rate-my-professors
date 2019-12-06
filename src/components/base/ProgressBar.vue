<template lang="pug">
    div(:style="rootStyle")
        div(:style="barStyle")
</template>

<script>
    export default {
        name: "ProgressBar",
        props: {
            frac: {
                type: Number,
                default: 0.8
            },
            width: {
                type: Number,
                default: 150
            },
            height: {
                type: Number,
                default: 10
            }
        },
        computed: {
            rootStyle: function () {
                return {
                    height: this.height <= 0 ? "100%" : this.height.toString() + "px",
                    width: this.width <= 0 ? "100%" : this.width.toString() + "px",
                    display: "inline-block",
                    background: "#00000011",
                    borderRadius: (this.height / 2).toString() + "px",
                    // boxShadow: "0 0 20px 0 gray"
                }
            },
            barStyle: function () {
                let color = "rgba(255,47,40,0.78)";
                if (this.frac >= 0.6 && this.frac < 0.8) {
                    color = "rgba(252,255,84,0.83)"
                } else if (this.frac >= 0.8) {
                    color="rgba(28,255,148,0.85)"
                }
                return {
                    background: color,
                    width: (this.width * this.frac).toString() + "px",
                    display: "inline-block",
                    height: "100%",
                    verticalAlign: "top",
                    borderRadius: (this.height / 2).toString() + "px",
                    boxShadow: "0 0 20px 0 " + color,
                }
            }
        }
    }
</script>

<style scoped>

</style>