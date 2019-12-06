<template lang="pug">
    .root(:style="rootStyle", @click="$emit('click')" @mouseenter="hover = true" @mouseleave="hover = false")
        .icon(:style="iconStyle")
            v-icon(:name="icon", :scale="2.5")
        p.text(:style="textStyle")
            slot
</template>

<script>
    export default {
        name: "IconTextButton",
        props: {
            icon: {
                type: String,
                default: "times"
            },
            down: {
                type: Boolean,
                default: false
            },
            width: {
                type: Number,
                default: -1
            },
            height: {
                type: Number,
                default: 96
            },
            color: {
                type: String,
                default: "white"
            }
        },
        data: function () {
            return {
                // publicPath: process.env.BASE_URL,
                hover: false
            }
        },
        computed: {
            rootStyle: function () {
                return {
                    // background: this.down || this.hover ? "black" : "unset",
                    width: this.width <= 0 ? "100%" : this.width.toString() + "px",
                    height: this.height <= 0 ? "100%" : this.height.toString() + "px"
                }
            },
            iconStyle: function () {
                return {
                    left: "50%",
                    top: "50%",
                    width: "100%",
                    // height: this.size.toString() + "px",
                    height: "64px",
                    transition: "300ms",
                    transform: this.hover ? "translate(-50%, -75%)" : "translate(-50%, -50%)",
                    color: this.color,
                }
            },
            textStyle: function () {
                return {
                    // color: this.hover ? "white" : "black",
                    opacity: this.hover ? "1" : "0",
                    transform: "translate(-50%, 40%)",
                    left: "50%",
                    top: "50%",
                    color: this.color
                }
            }
        }
    }
</script>

<style scoped lang="scss">
    p.text {
        text-align: center;
        /*color: black;*/
        letter-spacing: 2px;
        position: absolute;
        width: 100%;
        transition: 300ms;
    }

    div.root {
        display: inline-block;
        transition: 300ms;
        position: relative;
        cursor: pointer;
    }

    div.icon {
        display: flex;
        justify-content: center;
        align-items: center;
        /*height: 64px;*/
        position: absolute;
        /*left: 50%;*/
        /*top: 50%;*/
    }
</style>