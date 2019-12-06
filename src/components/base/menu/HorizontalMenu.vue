<template>
    <div>
        <Button1 v-for="(item, index) in items"
                 :key="index"
                 :style="itemStyle"
                 @click="$emit('click', index, item)"
                 fontsize="1.1em"
                 color="transparent"
                 hover-color="rgb(255, 148, 120)"
                 :width="120"
        >
            {{ item }}
        </Button1>
    </div>
</template>

<script>
    // import Button from "@/components/base/Button";
    import Button1 from "@/components/base/button/Button2";
    export default {
        name: "HorizontalMenu",
        components: {Button1},
        props: {
            items: {
                type: Array,
                default: function () {
                    return ["item1", "item2", "item3"]
                }
            },
            height: {
                type: String,
                default: "32px"
            },
            color: {
                type: String,
                default: "deepskyblue"
            }
        },
        computed: {
            itemStyle: function () {
                return {
                    height: this.height,
                    lineHeight: this.height.toString() + "px",
                    // margin: "0 8px"
                }
            }
        }
    }
</script>

<style scoped>

</style>