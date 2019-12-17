<template lang="pug">
    div(:style="rootStyle")
        input(:style="inputStyle", v-model="content", readonly="true")
        div(:style="iconStyle", @click="onClick")
            v-icon(name="chevron-down")
        div(v-if="expanded", @mouseleave="onMenuLeave")
            popup-menu2(:style="menuStyle", @click="onSelect", :items="options")
</template>

<script>
    import PopupMenu2 from "@/components/base/menu/PopupMenu2";
    export default {
        name: "MyCombo",
        components: {PopupMenu2},
        data: function () {
            return {
                expanded: false,
                content: ""
            }
        },
        props: {
            width: {
                type: Number,
                default: -1
            },
            height: {
                type: Number,
                default: 32
            },
            options: {
                type: Array,
                default: function () {
                    return ["op1", "op2", "op3"];
                }
            },
            color: {
                type: String,
                default: "#00000022",
            },
            value: {
                type: Number,
                default: -1
            },
        },
        methods: {
            onClick: function () {
                this.expanded = !this.expanded;
            },
            onSelect: function (index) {
                window.console.log(index);

                this.content = this.options[index];
                this.expanded = false;
                this.$emit("input", index);
            },
            onMenuLeave() {
                window.console.log("aaa");
                setTimeout(() => {
                    this.expanded = false;
                }, 1000);
            }
        },
        computed: {
            inputStyle: function () {
                return {
                    border: "none",
                    borderBottom: "2px solid " + this.color,
                    boxSizing: "border-box",
                    height: "100%",
                    width: "100%",
                    verticalAlign: "top",
                    outline: "none"
                }
            },
            rootStyle: function () {
                return {
                    display: "inline-block",
                    width: this.width <= 0 ? "100%" : `${this.width}px`,
                    height: `${this.height}px`,
                    position: "relative"
                }
            },
            iconStyle: function () {
                return {
                    display: "flex",
                    position: "absolute",
                    width: `${this.height}px`,
                    height: `${this.height}px`,
                    alignItems: "center",
                    justifyContent: "center",
                    right: "0",
                    top: "0",
                    cursor: "pointer",
                    transform: this.expanded ? "rotateZ(90deg)" : "rotateZ(0)",
                    transition: "300ms"
                }
            },
            menuStyle: function () {
                return {
                    right: "0",
                    top: `${this.height}px`
                }
            }
        }
    }
</script>

<style scoped>

</style>