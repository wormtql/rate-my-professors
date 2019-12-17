<template lang="pug">
    div(@mousemove="onMouseMove", :style="rootStyle", @click="onClick", @mouseleave="onMouseLeave")
        div(:style="iconStyle")
            v-icon(:name="score === 1 ? 'star-half-alt' : 'star'", :scale="1.4",)
        div(:style="iconStyle")
            v-icon(:name="score < 3 ? 'regular/star' : score === 3 ? 'star-half-alt' : 'star'", :scale="1.4",)
        div(:style="iconStyle")
            v-icon(:name="score < 5 ? 'regular/star' : score === 5 ? 'star-half-alt' : 'star'", :scale="1.4")
        div(:style="iconStyle")
            v-icon(:name="score < 7 ? 'regular/star' : score === 7 ? 'star-half-alt' : 'star'", :scale="1.4")
        div(:style="iconStyle")
            v-icon(:name="score < 9 ? 'regular/star' : score === 9 ? 'star-half-alt' : 'star'", :scale="1.4")
</template>

<script>
    export default {
        name: "Stars",
        props: {
            iconSize: {
                type: Number,
                default: 32
            },
            display: {
                type: Boolean,
                default: false
            },
            value: {
                type: Number,
                default: 1
            },
            color: {
                type: String,
                default: "#123456",
            }
        },
        computed: {
            iconStyle: function () {
                return {
                    height: this.iconSize.toString() + "px",
                    width: this.iconSize.toString() + "px",
                    display: "inline-flex",
                    alignItems: "center",
                    justifyContent: "center",
                    pointerEvents: "none",
                    verticalAlign: "top",
                    color: this.color,
                }
            },
            rootStyle: function () {
                return {
                    display: "inline-block",
                    width: (this.iconSize * 5).toString() + "px",
                    height: this.iconSize.toString() + "px",
                    cursor: "pointer"
                }
            }
        },
        methods: {
            onMouseMove: function (e) {
                // window.console.log(e);
                let x = e.offsetX;
                // let y = e.offsetY;
                let temp = Math.floor(2 * x / this.iconSize) + 1;

                if (temp != this.score) {
                    this.score = temp;
                    // this.$emit("input", this.score);
                }
                // window.console.log(this.score);
            },
            onMouseLeave: function () {
                // this.score = this.actualScore;
                this.score = this.value;
            },
            onClick: function (e) {
                let x = e.offsetX;
                let temp = Math.floor(2 * x / this.iconSize) + 1;
                if (temp != this.value) {
                    // this.actualScore = temp;
                    this.$emit("input", temp);
                }
            }
        },
        data: function () {
            return {
                score: 1,
                // actualScore: 5
            }
        }
    }
</script>

<style scoped>

</style>