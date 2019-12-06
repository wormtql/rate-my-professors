<template>
    <div :style="rootStyle">
        <div v-for="(item, index) in items"
             :key="index"
             :style="[itemStyle, {background: hover === index ? hoverColor : 'none'}]"
             @mouseenter="hover = index"
             @mouseleave="hover = -1"
             @click="$emit('click', item.name, index)"
        >
            <div :style="[iconStyle, {color: hover === index ? hoverTextColor : 'black'}]">
                <v-icon :name="item.icon" :scale="1.3"></v-icon>
            </div>
            <span :style="[textStyle, {color: hover === index ? hoverTextColor : 'black'}]">{{ item.caption }}</span>
        </div>
    </div>
</template>

<script>
    export default {
        name: "PopupMenu",
        data: function () {
            return {
                hover: -1
            }
        },
        props: {
            items: {
                type: Array,
                default: function () {
                    return [
                        {
                            name: "item1",
                            caption: "项目1",
                            icon: "times"
                        },
                        {
                            name: "item2",
                            caption: "项目2",
                            icon: "times"
                        }
                    ]
                }
            },
            width: {
                type: Number,
                default: 200
            },
            itemHeight: {
                type: Number,
                default: 48
            },
            hoverColor: {
                type: String,
                default: "lightblue"
            },
            hoverTextColor: {
                type: String,
                default: "white"
            }
        },
        computed: {
            itemStyle: function () {
                return {
                    width: this.width.toString() + "px",
                    height: this.itemHeight.toString() + "px",
                    cursor: "pointer"
                }
            },
            iconStyle: function () {
                return {
                    display: "inline-flex",
                    justifyContent: "center",
                    alignItems: "center",
                    width: this.itemHeight.toString() + "px",
                    height: "100%",
                }
            },
            textStyle: function () {
                return {
                    height: this.itemHeight.toString() + "px",
                    lineHeight: this.itemHeight.toString() + "px",
                    display: "inline-block",
                    verticalAlign: "top",
                    marginLeft: "16px"
                }
            },
            rootStyle: function () {
                return {
                    border: "1px solid lightgray",
                    // borderRadius: "5px"
                }
            }
        }
    }
</script>

<style scoped>

</style>