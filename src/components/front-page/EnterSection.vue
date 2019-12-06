<template lang="pug">
    -
        let shapeStyle = `
            position: absolute;
            width: 100%;
            height: 100%;
            left: 0;
            top: 0;
            pointer-events: none;
            z-index: 0;
            vertical-align: top;
            fill: #123456;
        `

    div(:style="rootStyle")
        div(:style="controlStyle")
            icon-button(icon-name="sign-in-alt", :width="44", :height="44", :margin="6", @click="component = 'LoginSection'")
            icon-button(icon-name="user-plus", :width="44", :height="44", :margin="6", @click="component = 'SignUpSection'",
                style="vertical-align: top")
            icon-button(icon-name="times", :width="44", :height="44", :margin="6", @click="$emit('close')",
                style="float: right", hover-color="#a16767ee", icon-color="white", hover-icon-color="white")
        div(:style="bodyStyle")
            component(:is="component")
            //- canvas(ref="canvas", style="position: absolute; width: 100%; left: 0; top: 0; pointer-events: none; z-index: 0;")
            svg(style=shapeStyle)
                circle(cx="200", cy="-280", r="350")
</template>

<script>
    import LoginSection from "@/components/front-page/LoginSection";
    import IconButton from "@/components/base/button/IconButton";
    import SignUpSection from "@/components/front-page/SignUpSection";
    export default {
        name: "EnterSection",
        components: {SignUpSection, IconButton, LoginSection},
        data: function () {
            return {
                component: "LoginSection",
                width: 400,
                height: 600,
                controlHeight: 44
            }
        },
        computed: {
            rootStyle: function () {
                return {
                    position: "absolute",
                    left: "0",
                    right: "0",
                    width: "100%",
                    height: "100%",
                    background: "#00000077",
                    display: "flex",
                    flexDirection: "column",
                    justifyContent: "center",
                    alignItems: "center",
                }
            },
            bodyStyle: function () {
                return {
                    background: "white",
                    width: this.width.toString() + "px",
                    position: "relative",
                    // borderTop: "4px solid #283539",
                    padding: "24px 32px",
                    boxSizing: "border-box"
                }
            },
            controlStyle: function () {
                return {
                    width: `${this.width}px`,
                    height: `${this.controlHeight}px`
                }
            }
        },
        methods: {

        }
    }
</script>

<style scoped>

</style>