<template lang="pug">
    div(:style="rootStyle")
        input(:style="inputStyle", v-model="content", @keyup.enter="onEnter", placeholder="添加标签")
        div(class="item-wrapper")
            p(v-if="items.length === 0", class="hint", style="font-size: 0.8em") 输入标签并按Enter键来添加标签
            div(v-for="(item, index) in items", class="item",)
                span(class="item-text") {{ item }}
                div(class="icon", @click="onDelete(index)")
                    v-icon(name="times" :scale="0.7")
</template>

<script>
    export default {
        name: "MultiTagBox",
        props: {
            inputHeight: {
                type: Number,
                default: 64
            },
            value: {
                type: Array,
                default: function () {
                    return []
                }
            },
            hasBorder: {
                type: Boolean,
                default: true
            },
            width: {
                type: Number,
                default: -1
            },
            inputBackground: {
                type: String,
                default: "ghostwhite"
            }
        },
        computed: {
            inputStyle: function () {
                return {
                    height: this.inputHeight.toString() + "px",
                    width: "100%",
                    outline: "none",
                    border: "none",
                    display: "inline-block",
                    padding: this.hasBorder ? "0 8px" : "0",
                    background: this.inputBackground,
                    boxSizing: "border-box",
                    marginBottom: "4px",
                }
            },
            rootStyle: function () {
                return {
                    borderLeft: this.hasBorder ? "5px solid black" : "none",
                    paddingLeft: this.hasBorder ? "4px" : "unset",
                    boxSizing: "border-box",
                    // display: "inline-block",
                    width: this.width <= 0 ? "100%" : this.width.toString() + "px"
                }
            },

        },
        data: function () {
            return {
                content: "",
                items: [],
                itemHeight: 24,
            }
        },
        methods: {
            onEnter: function (e) {
                // window.console.log(e.target.value);
                this.items.push(e.target.value);
                this.content = "";

                this.$emit("input", this.items);
            },
            onDelete: function (index) {
                this.items.splice(index, 1);

                this.$emit("input", this.items);
            }
        }
    }
</script>

<style scoped lang="scss">
    $item-height: 24px;

    div.item {
        display: inline-block;
        border-radius: $item-height / 2;
        background: rgba(211, 211, 211, 0.41);
        padding: 0 0 0 8px;
        /*margin: 4px;*/
        margin-right: 8px;
    }

    div.icon {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        height: $item-height - 8px;
        width: $item-height - 8px;
        vertical-align: top;
        border-radius: 50%;
        transition: 300ms;
        margin: 4px;
        cursor: pointer;
        &:hover {
            background: #eb8b96;
            color: white;
        };
        color: gray;
    }

    span.item-text {
        display: inline-block;
        height: $item-height;
        line-height: $item-height;
        vertical-align: top;
        font-size: 0.8em;
    }

    p.hint {
        color: gray;
        /*padding: 0 0 4px 4px;*/
    }
</style>