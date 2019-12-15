<template lang="pug">
    div
        span
            label-button(style="margin-right: 16px",
                @click="navigate(-1)") 上一页

            label-button(v-show="value >= 3", style="color: #00000055; padding: 0 4px; font-size: 0.8em",
                @click="navigate(-2)") {{ value - 2 }}
            label-button(v-show="value >= 2", style="color: #00000088; padding: 0 4px; font-size: 0.8em",
                @click="navigate(-1)") {{ value - 1 }}
            span(style="padding: 0 4px; color: white; font-size: 0.8em; background: #123456") {{ value }}
            label-button(v-show="value + 1 <= total", style="color: #00000088; padding: 0 4px; font-size: 0.8em",
                @click="navigate(1)") {{ value + 1 }}
            label-button(v-show="value + 2 <= total", style="color: #00000055; padding: 0 4px; font-size: 0.8em",
                @click="navigate(2)") {{ value + 2 }}
            label-button(style="font-size: 0.8em", v-show="value + 2 < total") ...
            label-button(style="font-size: 0.8em; margin: 0 4px", v-show="value + 2 < total",
                @click="navigate(total - value)") {{ total }}

            label-button(style="margin-left: 16px",
                @click="navigate(1)") 下一页
</template>

<script>
    import LabelButton from "@/components/base/button/LabelButton";
    export default {
        name: "Pager",
        components: {LabelButton},
        data: function () {
            return {
                // current: 1
            }
        },
        props: {
            total: {
                type: Number,
                default: 7
            },
            value: {
                type: Number,
                default: 1
            }
            // current: {
            //     type: Number,
            //     default: 3
            // }
        },
        methods: {
            navigate: function (by) {
                let temp = this.value + by;
                if (temp <= 0) {
                    temp = 1;
                }
                if (temp > this.total) {
                    temp = this.total;
                }

                // if (temp != this.current) {
                //     this.current = temp;
                //     this.$emit("navigate", temp);
                // }
                // window.console.log(by)
                if (temp != this.value) {
                    this.$emit("navigate", temp);
                }
                
            }
        },
        // model: {
        //     prop: "current",
        //
        // }
    }
</script>

<style scoped>

</style>