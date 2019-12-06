<template lang="pug">
    button(@click="$emit('click')", :style="buttonStyle", @mouseenter="hover = true", @mouseleave="hover = false")
        slot
</template>

<script>
    export default {
        name: "LabelButton",
        data: function () {
            return {
                hover: false,
            }
        },
        computed: {
            buttonStyle: function () {
                return {
                    outline: "none",
                    border: "none",
                    background: "none",
                    transition: "300ms",
                    color: this.hover ? this.hoverColor : this.color,
                    cursor: "pointer",
                    fontSize: this.fontSize
                }
            }
        },
        props: {
            color: {
                type: String,
                default: "black"
            },
            hoverColor: {
                type: String,
                default: "gray"
            },
            fontSize: {
                type: String,
                default: "0.8em"
            }
        }
    }
</script>

<style scoped>

</style>