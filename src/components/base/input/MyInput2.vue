<template lang="pug">
    div(:style="rootStyle")
        input(:style="inputStyle", @focusin="focus = true", @focusout="focus = false", :value="content", @input="input",
            :type="pwd ? 'password' : 'text'")
        div(:style="iconStyle")
            v-icon(:name="iconName" :scale="scale")
        p(:style="textStyle") {{ ph }}

        div(v-if="error !== ''", :style="errorStyle")
            div(style=`display: inline-flex; height: 100%; justify-content: center; align-items: center; width: ${alertHeight}px;
                color: white; vertical-align: top`)
                v-icon(name="exclamation-circle" :scale="0.8")
            span(style=`height: ${alertHeight}px; line-height: ${alertHeight}px; vertical-align: top; padding: 0 0 0 8px;
                color: white; font-size: 0.8em`) {{ error }}
</template>

<script>
    export default {
        name: "MyInput2",
        props: {
            iconName: {
                type: String,
                default: "user"
            },
            height: {
                type: Number,
                default: 48,
            },
            width: {
                type: Number,
                default: -1
            },
            ph: {
                type: String,
                default: "placeholder"
            },
            scale: {
                type: Number,
                default: 1.0,
            },
            color: {
                type: String,
                default: "#cc33cc"
            },
            value: {
                type: String,
                default: ""
            },
            pwd: {
                type: Boolean,
                default: false
            },
            error: {
                type: String,
                default: ""
            }
        },
        data: function () {
            return {
                // active: false,
                focus: false,
                content: ""
            }
        },
        methods: {
            input (e) {
                this.content = e.target.value;
                this.$emit("input", this.content);
            }
        },
        computed: {
            errorStyle: function () {
                return {
                    background: "#ff3456aa",
                    height: "20px",
                    lineHeight: "20px",
                    position: "absolute",
                    right: "0",
                    top: "-15px",
                    padding: "0 4px"
                }
            },
            inputStyle: function () {
                return {
                    outline: "none",
                    border: "none",
                    borderBottom: this.focus ? "2px solid " + this.color : "2px solid #00000044",
                    width: "100%",
                    boxSizing: "border-box",
                    height: "100%",
                    display: "block",
                    padding: `0 ${this.height}px 0 0`,
                    fontSize: "1.1em",
                }
            },
            rootStyle: function () {
                return {
                    width: this.width <= 0 ? "100%" : this.width.toString() + "px",
                    height: this.height.toString() + "px",
                    position: "relative",
                }
            },
            iconStyle: function () {
                return {
                    position: "absolute",
                    right: "0",
                    top: "0",
                    width: this.height.toString() + "px",
                    height: this.height.toString() + "px",
                    display: "flex",
                    alignItems: "center",
                    justifyContent: "center",
                    // color: "#00000055"
                }
            },
            textStyle: function () {
                return {
                    pointerEvents: "none",
                    position: "absolute",
                    left: "0",
                    top: this.active ? "-15px" : "0",
                    display: "block",
                    height: this.active ? "20px" : `${this.height}px`,
                    lineHeight: this.active ? "20px" : `${this.height}px`,
                    color: this.active ? "black" : "gray",
                    transition: "300ms",
                    fontSize: this.active ? "0.8em" : "unset",
                    // background: this.active ? this.color : "unset",
                }
            },
            active: function () {
                return this.focus && this.content === "" || this.content !== "";
            }
        }
    }
</script>

<style scoped>

</style>