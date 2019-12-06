<template lang="pug">
    -
        let hint = "请自觉遵守互联网相关的政策法规，严禁发布色情、暴力、反动的言论";
        let inputStyle = `
            border: none;
            border-bottom: 2px solid #00000022;
            height: 32px;
            box-sizing: border-box;
            outline: none;
            // padding: 0 8px;
            font-size: 0.9em;
            width: 100%;
            // border-radius: 16px;
        `;
        let tagStyle = `
            font-size: 0.8em;
            height: 24px;
            line-height: 24px;
            border-radius: 1000px;
            background: #00000011;
            padding: 0 8px;
            margin: 4px 4px;
            // display: inline-block;
            cursor: pointer;
            // word-wrap: nowrap;
            white-space: nowrap;
        `;


    div(style="display: flex; align-items: center; justify-content: center; position: absolute; left: 0; top: 0; width: 100%; height: 100%; background: #00000055; box-sizing: border-box")
        div(style="width: 400px; background: white; padding: 24px 24px; height: 500px; overflow: auto")
            h2(style="padding: 0 0 24px 0; border-bottom: 1px solid #00000022; margin-bottom: 16px;") 为 "{{ info.name }}" 写评价

            // quality
            div(style="display: flex; align-items: center")
                h4(style="display: inline-block; width: 170px") 总体评分：
                stars(v-model="quality")

            // difficulty
            div(style="display: flex; align-items: center")
                h4(style="display: inline-block; width: 170px") 难度（越高越难）：
                stars(v-model="difficulty")

            // course
            div(style="margin: 8px 0 0 0")
                h4(style="display: inline-block; width: 170px;") 我选修的课程：
                my-combo(:width="-1", :options="info.courses", v-model="course")

            // score
            div(style="padding: 8px 0 8px 0")
                h4(style="display: inline-block; width: 170px") 我获得的分数：
                input(type="text", style=inputStyle, v-model="score")

            // tags
            h4(style="margin: 8px 0 16px 0;") 标签：
            div(style="border-left: 2px solid #123456; display: flex; flex-wrap: wrap; padding-left: 4px;")
                span(v-for="(item, index) in info.tags", :key="index", style=tagStyle, @click="onTagClick(item, index)",
                :style="selectedTags.indexOf(index) >= 0 ? selectedStyle : {}") {{ item }}

            h4(style="margin: 16px 0 16px 0") 选项：

            // take again
            my-check(style="padding: 0px 0 8px 0", v-model="takeAgain") 如果重来我还会再选

            // attendance
            my-check(style="padding: 4px 0 16px 0", v-model="attendance") 上课会点名

            // comment
            h4(style="margin-bottom: 8px; margin-top: 4px") 评价：
            textarea(style="width: 100%; resize: none; height: 100px; padding: 8px; box-sizing: border-box; background: ghostwhite; border: none",
                placeholder=hint, v-model="comment")


            button1(:width="100", :height="32", color="#123456", hover-color="#123456aa",
                style="margin: 32px 0 0 0", @click="onConfirm") 发表
            button1(:width="100", :height="32", color="#123456", hover-color="#123456aa",
                style="margin: 32px 0 0 24px;", @click="onCancel()") 取消
</template>

<script>
    import Stars from "@/components/base/Stars";
    import Button1 from "@/components/base/button/Button2";
    import MyCheck from "@/components/base/MyCheck";
    import MyCombo from "@/components/base/MyCombo";
    // import MyComboBox from "@/components/base/MyComboBox";
    export default {
        name: "CommentBox",
        components: {MyCombo, MyCheck, Button1, Stars},
        props: {
            info: {
                type: Object,
                default: function () {
                    return {
                        tags: ["tag1", "tag2", "tag3"],
                        name: "金旭亮",
                        courses: ["course1", "course2", "course3"]
                    }
                }
            }
        },
        created: function () {
            window.console.log(this.info);
        },
        data: function () {
            return {
                selectedTags: [],
                quality: 1,
                difficulty: 1,
                comment: "",
                takeAgain: false,
                attendance: false,
                score: "",
                course: -1,

                selectedStyle: {
                    background: "#123456",
                    color: "white"
                },


            }
        },
        methods: {
            onTagClick(name, index) {
                window.console.log(name, index);
                let idx = this.selectedTags.indexOf(index);
                if (idx >= 0) {
                    this.selectedTags.splice(idx, 1);
                } else {
                    this.selectedTags.push(index);
                }
            },
            onCancel () {
                this.$emit("cancel");
            },
            onConfirm () {
                let data = {
                    course: this.course,
                    quality: this.quality,
                    difficulty: this.difficulty,
                    takeAgain: this.takeAgain,
                    attendance: this.attendance,
                    score: this.score,
                    tags: this.selectedTags,
                    comment: this.comment,
                };

                // window.console.log(data);

                this.$emit("comment", data);
            }
        }
    }
</script>

<style scoped>

</style>