<template lang="pug">
    div(:style="rootStyle")
        div(v-for="(item, index) in items", :key="index",
            :style="[itemStyle, {background: index === current ? hoverColor : index % 2 === 0 ? color1 : color2}]",
            @mouseenter="current = index", @mouseleave="current = -1", @click="$emit('click', index)") {{ item }}
</template>

<script>
    export default {
        name: "PopupMenu2",
        data: function () {
            return {
                current: -1,
            }
        },
        props: {
            items: {
                type: Array,
                default: function () {
                    return ["item1", "item2", "item3"]
                }
            },
            width: {
                type: Number,
                default: -1,
            },
            itemHeight: {
                type: Number,
                default: 32,
            },
            color1: {
                type: String,
                default: "#123456"
            },
            color2: {
                type: String,
                default: "#345678"
            },
            hoverColor: {
                type: String,
                default: "#456789"
            }
        },
        computed: {
            rootStyle: function () {
                return {
                    width: this.width <= 0 ? "unset" : `${this.width}px`,
                    display: "inline-block",
                    position: "absolute",
                }
            },
            itemStyle: function () {
                return {
                    padding: "4px 8px",
                    color: "white",
                    cursor: "pointer",
                }
            }
        }
    }
</script>

<style scoped>

</style>