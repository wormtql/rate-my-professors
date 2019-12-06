<template>
    <button :style="buttonStyle" @click="$emit('click')"
            @mouseenter="hover = true"
            @mouseleave="hover = false"
    >
        <v-icon :name="iconName" :style="iconStyle" :scale="fontsize"></v-icon>
    </button>
</template>

<script>
    export default {
        name: "IconButton",
        props: {
            iconName: {
                type: String,
                default: "times"
            },
            iconColor: {
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
                type: Number,
                default: 1
            },
            margin: {
                type: Number,
                default: 16
            },
            hoverColor: {
                type: String,
                default: "#ffffff77"
            },
            hoverIconColor: {
                type: String,
                default: "#000000"
            }
        },
        data: function () {
            return {
                hover: false
            }
        },
        computed: {
            iconStyle: function () {
                return {
                    color: this.hover ? this.hoverIconColor : this.iconColor,
                    fontSize: this.fontsize
                }
            },
            buttonStyle: function () {
                return {
                    height: this.height === -1 ? "unset" : (this.height - 2 * this.margin).toString() + "px",
                    width: this.width === -1 ? "unset" : (this.width - 2 * this.margin).toString() + "px",
                    margin: this.margin.toString() + "px",
                    borderRadius: this.hover ? "50%" : "unset",
                    background: this.hover ? this.hoverColor : "none",
                    display: "inline-flex",
                    justifyContent: "center",
                    alignItems: "center"
                }
            }
        }
    }
</script>

<style scoped>
    button {
        outline: none;
        /*background: none;*/
        border: none;
        transition: 300ms;
        display: inline-block;
        cursor: pointer;
    }

    button:hover {
        border-radius: 50%;
        background: #ffffffaa;
    }
</style>