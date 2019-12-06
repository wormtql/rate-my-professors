<template>
    <button :style="itemStyle" class="button1" @mouseenter="hover = true" @mouseleave="hover = false" @click="$emit('click')">
        <span :style="[span0Style, spanStyle]"></span>
        <span :style="[span1Style, spanStyle]"></span>
        <span :style="[span2Style, spanStyle]"></span>
        <span :style="[span3Style, spanStyle]"></span>
        <slot></slot>
    </button>
</template>

<script>
    export default {
        name: "Button",
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
                    width: this.width === -1 ? "unset" : this.width.toString() + "px",
                    fontSize: this.fontsize
                }
            },
            offset_value: function () {
                return this.hover ? "0" : this.offset.toString() + "px"
            },
            spanStyle: function () {
                return {
                    opacity: this.hover ? 1 : 0
                }
            },
            span0Style: function () {
                return {
                    left: this.offset_value,
                    top: this.offset_value,
                    borderLeft: "2px solid " + this.color,
                    borderTop: "2px solid " + this.color
                }
            },
            span1Style: function () {
                return {
                    right: this.offset_value,
                    top: this.offset_value,
                    borderTop: "2px solid " + this.color,
                    borderRight: "2px solid " + this.color
                }
            },
            span2Style: function () {
                return {
                    right: this.offset_value,
                    bottom: this.offset_value,
                    borderBottom: "2px solid " + this.color,
                    borderRight: "2px solid " + this.color
                }
            },
            span3Style: function () {
                return {
                    left: this.offset_value,
                    bottom: this.offset_value,
                    borderBottom: "2px solid " + this.color,
                    borderLeft: "2px solid " + this.color
                }
            }
        }
    }
</script>

<style scoped>
    button {
        display: inline-block;
        position: relative;
        padding: 0 16px;
        outline: none;
        background: none;
        border: none;
        font-family: "consolas", sans-serif;
        text-transform: uppercase;
        color: white;
    }

    button span {
        width: 8px;
        height: 8px;
        transition: 100ms;
        position: absolute;
        display: inline-block;
    }
</style>