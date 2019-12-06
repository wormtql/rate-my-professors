<template lang="pug">
    button(:style="itemStyle",
        @mouseenter="hover = true",
        @mouseleave="hover = false",
        @click="$emit('click')"
    )
        slot
</template>

<script>
    export default {
        name: "Button1",
        data: function () {
            return {
                hover: false,
                offset: 5,

            }
        },
        props: {
            color: {
                type: String,
                default: "deepskyblue"
            },
            hoverColor: {
                type: String,
                default: "#123456",
            },
            textColor: {
                type: String,
                default: "white"
            },
            textHoverColor: {
                type: String,
                default: "white"
            },
            height: {
                type: Number,
                default: -1
            },
            width: {
                type: Number,
                default: -1
            },
            fontsize: {
                type: String,
                default: "1em"
            }
        },
        computed: {
            itemStyle: function () {
                return {
                    height: this.height === -1 ? "unset" : this.height.toString() + "px",
                    width: this.width <= 0 ? "100%" : this.width.toString() + "px",
                    fontSize: this.fontsize,
                    background: this.hover ? this.hoverColor : this.color,
                    cursor: "pointer",
                    display: "inline-block",
                    padding: "0 16px",
                    outline: "none",
                    border: "none",
                    fontFamily: "consolas",
                    textTransform: "uppercase",
                    color: this.hover ? this.textHoverColor : this.textColor,
                    transition: "200ms",
                    letterSpacing: "2px"
                }
            },
        }
    }
</script>

<style scoped>

</style>