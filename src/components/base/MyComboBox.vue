<template lang="pug">
    div(:style="rootStyle")
        div(:style="iconStyle")
            v-icon(:name="icon", scale="1.4", style="color: white")
        div(:style="icon2Style" @click="onRightClicked")
            v-icon(name="chevron-down")
        label
            input(type="text",
                @focusout="focusout",
                :value="content",
                :style="inputStyle",
                readonly="true")
        p(:style="labelStyle") {{ placeholder }}
        popup-menu(:width="150", :style="menuStyle" v-show="menuShow",
            :items="menuItems", hover-color="black", @click="onMenuClicked")
</template>

<script>
    import PopupMenu from "@/components/base/menu/PopupMenu";
    export default {
        name: "MyComboBox",
        components: {PopupMenu},
        data: function () {
            return {
                isActive: false,
                menuShow: false,
                menuItems: [
                    {
                        name: "male",
                        caption: "男",
                        icon: "mars"
                    },
                    {
                        name: "female",
                        caption: "女",
                        icon: "venus"
                    }
                ],
                content: ""
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
            },
            items: {
                type: Array,
                default: function () {
                    return ["item1", "item2"]
                }
            }
        },
        methods: {
            focusout: function () {
                if (this.content === "") {
                    this.isActive = false
                }
            },
            onRightClicked: function () {
                this.menuShow = !this.menuShow;
            },
            onMenuClicked: function (name) {
                // window.console.log(name)
                if (name === "male") {
                    this.content = "男"
                } else if (name === "female") {
                    this.content = "女"
                }

                this.isActive = true;
                this.menuShow = false;
                this.$emit("input", name);
            },
        },
        computed: {
            inputStyle: function () {
                return {
                    borderBottom: "2px solid " + this.color,
                    height: this.height.toString() + "px",
                    // width: (this.width - this.height).toString() + "px",
                    width: "calc(100% - " + this.height.toString() + "px)",
                    left: this.height.toString() + "px",
                    boxSizing: "border-box",
                    // readOnly: "true"
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
            },
            icon2Style: function () {
                return {
                    display: "inline-flex",
                    alignItems: "center",
                    justifyContent: "center",
                    height: this.height.toString() + "px",
                    width: this.height.toString() + "px",
                    position: "absolute",
                    right: "0",
                    top: "0",
                    zIndex: "100",
                    cursor: "pointer"
                }
            },
            menuStyle: function () {
                return {
                    position: "absolute",
                    top: this.height.toString() + "px",
                    right: "0"
                }
            },
        }
    }
</script>

<style scoped lang="scss">
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