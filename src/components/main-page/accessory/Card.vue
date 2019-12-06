<template>
    <div :style="rootStyle" @mouseenter="hover = true" @mouseleave="hover = false">
        <img :src="`${publicPath}${img}`" :style="imgStyle" />
        <h1 :style="headerStyle">{{ header }}</h1>
        <p :style="descriptionStyle">{{ description }}</p>
        <IconButton icon-name="arrow-right"
                    :fontsize="2"
                    :style="buttonStyle"
                    :margin="0"
                    :width="32"
                    :height="32"
                    icon-color="black"
                    hover-color="transparent"
                    @click="$emit('click')"
        ></IconButton>
    </div>
</template>

<script>
    import IconButton from "@/components/base/button/IconButton";
    export default {
        name: "Card",
        components: {IconButton},
        props: {
            color: {
                type: String,
                default: "#0000ff11"
            },
            img: {
                type: String,
                default: "note.svg"
            },
            header: {
                type: String,
                default: "HEADER"
            },
            height: {
                type: Number,
                default: 200
            },
            description: {
                type: String,
                default: "lorem ah askshdkj j  ajkhjda  hjahsj h haj hjsah hj akhd jkashdakjdh jakh daskj "
            }
        },
        data: function () {
            return {
                publicPath: process.env.BASE_URL,
                hover: false
            }
        },
        computed: {
            rootStyle: function () {
                return {
                    background: this.color,
                    height: this.height.toString() + "px",
                    position: "relative"
                }
            },
            imgStyle: function () {
                return {
                    width: this.hover ? (this.height - 64).toString() + "px" : "64px",
                    height: this.hover ? (this.height - 64).toString() + "px" : "64px",
                    top: "50%",
                    left: this.hover ? "32px" : "50%",
                    position: "absolute",
                    transform: this.hover ? "translate(0, -50%)" : "translate(-50%, -100%)",
                    transition: "300ms"
                }
            },
            headerStyle: function () {
                return {
                    position: "absolute",
                    top: this.hover ? "32px" : "50%",
                    left: this.hover ? this.height.toString() + "px" : "50%",
                    transform: this.hover ? "translate(0, 0)" : "translate(-50%, 50%)",
                    letterSpacing: "2px",
                    color: "dimgray",
                    transition: "300ms"
                }
            },
            descriptionStyle: function () {
                return {
                    position: "absolute",
                    transition: "300ms",
                    opacity: this.hover ? "1" : "0",
                    left: this.height.toString() + "px",
                    top: "80px",
                    width: "calc(100% - " + (this.height + 100).toString() + "px)"
                }
            },
            buttonStyle: function () {
                return {
                    position: "absolute",
                    right: "24px",
                    top: "50%",
                    transform: "translateY(-50%)",
                    opacity: this.hover ? "1" : "0"
                }
            }
        }
    }
</script>

<style scoped>

</style>