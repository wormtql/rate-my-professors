<template lang="pug">
    -
        let headerHeight = "20px";
        let style1 = `
            margin-left: 16px;
            font-size: 0.8em;
            vertical-align: top;
            height: ${headerHeight};
            line-height: ${headerHeight};
            display: inline-block;
            color: gray
        `;

        let style2 = `
            margin-left: 8px;
            font-size: 0.8em;
            vertical-align: top;
            height: ${headerHeight};
            line-height: ${headerHeight};
            color: gray;
            display: inline-block;
        `;

        let tagStyle = `
            padding: 0 8px;
            font-size: 0.8em;
            display: inline-block;
            height: 20px;
            border-radius: 10px;
            background: #00000015;
            margin: 4px;
            color: gray;
            vertical-align: top;
        `;

    div
        // meta info
        div(style="height: " + headerHeight)
            span(:style="[widgetStyle, {background: color1, marginRight: '8px', color: 'white'}]", title="给这位老师的总分") {{ data.quality }}
            span(:style="[widgetStyle, {background: color2, marginRight: '8px', color: 'white'}]", title="给这位老师的难度分（越高越难）") {{ data.difficulty }}
            span(:style="[widgetStyle, {background: '#123456', color: 'white'}]", :title="data.takeAgain ? '会再选' : '不会再选'") {{ data.takeAgain ? "T" : "F" }}
            span(style=style1) 选修 《{{ data.course }}》
            span(v-if = "data.grade > 0", style=style2) 获得了 {{ data.grade }} 分
            span(style=style2 + "float: right") {{ data.positive }}
            icon-button(:margin="0", icon-name="thumbs-up", icon-color="gray", :height="20", :width="20", :fontsize="0.8"
                style="float: right", @click="onThumbsUp")
            span(style=style2 + "float: right; margin-right: 8px") {{ data.negative }}
            icon-button(:margin="0", icon-name="thumbs-down", icon-color="gray", :height="20", :width="20", :fontsize="0.8"
                style="float: right", @click="onThumbsUp")
        // comment
        div(style="padding: 8px 0") {{ data.comment }}

        // tags
        div(style="border-left: 3px solid black; display: flex; align-items: center; padding-left: 4px; flex-wrap: wrap")
            span(v-for="(item, index) in data.tags", style=tagStyle) {{ item }}

        div(style="height: 20px")
            span(style="float: right; color: gray; height: 20px; font-size: 0.8em; margin-left: 16px; cursor: pointer",
                @click="onReport") 举报
            span(style="float: right; color: gray; height: 20px; font-size: 0.8em") {{ data.date }}

</template>

<script>
    import IconButton from "@/components/base/button/IconButton";
    export default {
        name: "CommentItem",
        components: {IconButton},
        props: {
            data: {
                type: Object,
                default: function () {
                    return {
                        course: "Java",
                        quality: 7,
                        difficulty: 2,
                        takeAgain: false,
                        attendance: true,
                        grade: 90,
                        tags: ["难", "szd", "tnl"],
                        comment: "php是世界上最好的语言",
                        positive: 666,
                        negative: 128,
                        date: "2019/11/11"
                    }
                }
            }
        },
        data: function () {
            return {
                red: "rgba(255,47,40,0.5)",
                yellow: "rgba(252,255,84,0.5)",
                green: "rgba(28,255,148,0.5)"
            }
        },
        methods: {
            onThumbsUp: function () {
                this.$emit("thumbsup");
            },
            onThumbsDown: function () {
                this.$emit("thumbsdown");
            },
            onReport: function () {
                this.$emit("report");
            }
        },
        computed: {
            widgetStyle: function () {
                return {
                    display: "inline-block",
                    height: "20px",
                    width: "20px",
                    verticalAlign: "top",
                    borderRadius: "50%",
                    fontSize: "0.7em",
                    color: "black",
                    textAlign: "center",
                    lineHeight: "20px",
                }
            },
            color1: function () {
                // let x = this.data.quality / 10.0;
                // if (x < 0.6) {
                //     return this.red;
                // } else if (x >= 0.6 && x < 0.8) {
                //     return this.yellow;
                // } else {
                //     return this.green;
                // }

                return "#123456";
            },
            color2: function () {
                // let x = this.data.difficulty / 10.0;
                // if (x > 0.8) {
                //     return this.red;
                // } else if (x <= 0.8 && x > 0.6) {
                //     return this.yellow;
                // } else {
                //     return this.green;
                // }

                return "#123456";
            }
        }
    }
</script>

<style scoped>

</style>