<template lang="pug">
    div(:style="rootStyle", @click="onChange")
        div(:style="iconStyle")
            v-icon(name="check" v-if="checked" :scale="0.8")
        p(:style="textStyle")
            slot
</template>

<script>
    export default {
        name: "MyCheck",
        data: function () {
            return {
                checked: false,
                height: 18
            }
        },
        props: {
            value: {
                type: Boolean,
                default: false
            },
            checkedColor: {
                type: String,
                default: "#CC33CC"
            }
        },
        computed: {
            iconStyle: function () {
                return {
                    color: "white",
                    width: this.height.toString() + "px",
                    height: this.height.toString() + "px",
                    display: "inline-flex",
                    justifyContent: "center",
                    alignItems: "center",
                    border: this.checked ? "none" : "2px solid lightgray",
                    boxSizing: "border-box",
                    verticalAlign: "top",
                    borderRadius: "2px",
                    background: this.checked ? this.checkedColor : "none",

                }
            },
            textStyle: function () {
                return {
                    display: "inline-block",
                    height: this.height.toString() + "px",
                    lineHeight: this.height.toString() + "px",
                    verticalAlign: "top",
                    fontSize: "0.8em",
                    marginLeft: "4px"
                }
            },
            rootStyle: function () {
                return {
                    height: this.height.toString() + "px",
                    cursor: "pointer",
                    // display: "inline-flex",
                    // alignItems: "center"
                }
            }
        },
        methods: {
            onChange: function () {
                this.checked = !this.checked;
                this.$emit("input", this.checked);
            }
        }
    }
</script>

<style scoped>

</style>