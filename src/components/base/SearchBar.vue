<template>
    <div :style="rootStyle">
        <label>
            <input type="text"
                   :style="inputStyle"
                   v-model="content"
                   @keyup.enter="$emit('search', $event.target.value)"
                   :placeholder="placeholder"
            />
        </label>
        <div :style="iconStyle">
            <v-icon name="search"></v-icon>
        </div>
        <IconButton icon-name="times"
                    :style="buttonStyle"
                    :width="innerHeight"
                    :height="innerHeight"
                    icon-color="gray"
                    :margin="8"
                    hover-color="darkgray"
                    v-show="content !== ''"
                    @click="onCancelClicked"
        ></IconButton>
    </div>
</template>

<script>
    import IconButton from "@/components/base/button/IconButton";
    export default {
        name: "SearchBar",
        components: {IconButton},
        props: {
            width: {
                type: Number,
                default: 500
            },
            color: {
                type: String,
                default: "dimgray"
            },
            height: {
                type: Number,
                default: 48
            },
            placeholder: {
                type: String,
                default: "ph"
            }
        },
        computed: {
            inputStyle: function () {
                return {
                    outline: "none",
                    height: (this.height).toString() + "px",
                    display: "inline-block",
                    padding: "0 " + (this.innerHeight).toString() + "px",
                    border: "2px solid " + this.color,
                    // width: this.width === -1 ? "100%" : (this.width - 2 * this.innerHeight - 4).toString() + "px",
                    width: "100%",
                    letterSpacing: "2px",
                    boxSizing: "border-box",
                    borderRadius: "100px"
                }
            },
            rootStyle: function () {
                return {
                    position: "relative",
                    // display: "inline-block",
                    // width: this.width <= 0 ? "100%" : (this.width - 2 * this.innerHeight - 4).toString() + "px",
                }
            },
            iconStyle: function () {
                return {
                    position: "absolute",
                    left: "2px",
                    top: "2px",
                    width: this.innerHeight.toString() + "px",
                    height: this.innerHeight.toString() + "px",
                    display: "flex",
                    justifyContent: "center",
                    alignItems: "center",
                    color: "gray"
                }
            },
            buttonStyle: function () {
                return {
                    position: "absolute",
                    right: "2px",
                    top: "2px",
                }
            },
            innerHeight: function () {
                return this.height - 4
            }
        },
        data: function () {
            return {
                content: ""
            }
        },
        methods: {
            onCancelClicked: function () {
                this.content = ""
            }
        }
    }
</script>

<style scoped>

</style>