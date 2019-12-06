<template lang="pug">
    div(:style="rootStyle")
        div(:style="iconStyle")
            v-icon(:name="icon", scale="1.4", style="color: white")
        label
            input(:type="password ? 'password' : 'text'"
                @focusin="isActive = true"
                @focusout="focusout"
                @input="$emit('input', $event.target.value)"
                ref="input"
                :value="value"
                :style="inputStyle")
        p(:class="{active: isActive}" :style="labelStyle") {{ placeholder }}
</template>

<script>
    export default {
        name: "MyInput",
        data: function () {
            return {
                isActive: false
            }
        },
        props: {
            placeholder: {
                type: String,
                default: "placeholder"
            },
            value: {
                type: String,
                default: ""
            },
            password: {
                type: Boolean,
                default: false
            },
            icon: {
                type: String,
                default: "exclamation-circle"
            },
            color: {
                type: String,
                default: "black"
            },
            width: {
                type: Number,
                default: 400
            },
            height: {
                type: Number,
                default: 40
            }
        },
        methods: {
            focusout: function () {
                if (this.$refs.input.value === "") {
                    this.isActive = false
                }
            }
        },
        computed: {
            inputStyle: function () {
                return {
                    borderBottom: "2px solid " + this.color,
                    height: this.height.toString() + "px",
                    // width: (this.width - this.height).toString() + "px",
                    width: "calc(100% - " + this.height.toString() + "px)",
                    left: this.height.toString() + "px",
                    boxSizing: "border-box"
                }
            },
            iconStyle: function () {
                return {
                    position: "absolute",
                    width: this.height.toString() + "px",
                    height: this.height.toString() + "px",
                    display: "flex",
                    justifyContent: "center",
                    alignItems: "center",
                    background: this.color
                }
            },
            labelStyle: function () {
                return {
                    position: "absolute",
                    left: this.isActive ? "0" : (this.height + 8).toString() + "px",
                    top: this.isActive ? "-20px" : "0",
                    height: this.isActive ? "20px" : (this.height - 2).toString() + "px",
                    lineHeight: this.isActive ? "unset" : (this.height - 2).toString() + "px",
                    color: this.isActive ? this.color : "lightgray",
                    fontSize: this.isActive ? "0.8em" : "1em"
                }
            },
            rootStyle: function () {
                return {
                    height: this.height.toString() + "px",
                    width: this.width <= 0 ? "100%" : this.width.toString() + "px",
                    position: "relative",
                    display: "inline-block"
                }
            }
        }
    }
</script>

<style scoped>
    input {
        outline: none;
        position: absolute;
        top: 0;
        box-sizing: border-box;
        border: none;
        padding: 0 8px;
        background-color: ghostwhite;
    }

    p {
        position: absolute;
        margin: 0;
        transition: 300ms;
        pointer-events: none;
    }

    /*p.active {*/
    /*    transform: translateY(-32px);*/
    /*    height: 15px;*/
    /*    line-height: 15px;*/
    /*    font-size: 0.8em;*/
    /*    left: 0;*/
    /*}*/
</style>