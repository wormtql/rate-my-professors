<template lang="pug">
    -
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
        let hint = "请自觉遵守互联网相关的政策法规，严禁发布色情、暴力、反动的言论";
        let buttonStyle = `
            position: fixed;
            bottom: 16px;
            padding: 16px 0;
            left: 396px;
            // width: calc(100% - 696px);
            display: block;
            box-sizing: border-box;
            padding: 16px;
            background: white;
            box-shadow: 0 0 40px 1px #00000044;
            // border-top-left-radius: 8px;
            // border-top-right-radius: 8px;
            border-radius: 8px;
        `

    div(style="padding: 32px 300px; position: relative;")
        info-dialog(v-if="showDialog", :icon="dialogIcon", :text="dialogText",
            :icon-color="dialogIconColor")

        div(v-if="loading")
            loading-box(color="#123456")
            h4 加载中
        div(v-if="!loading && !loadSuccess")
            p {{ errorInfo }}
        div(v-if="!loading && loadSuccess")
            h1 为 {{ info.name }} 撰写评价
            spacer(:height="32")
            divider
            spacer(:height="24")

            // quality
            div(style="display: flex; align-items: center")
                h4(style="display: inline-block; width: 170px") 总体评分：
                stars(v-model="quality")

            // difficulty
            div(style="display: flex; align-items: center")
                h4(style="display: inline-block; width: 170px") 难度（越高越难）：
                stars(v-model="difficulty")

            spacer(:height="24")
            divider
            spacer(:height="24")

            // course
            div
                h4(style="display: inline-block; width: 170px;") 我选修的课程：
                my-combo(:width="-1", :options="info.courses | courseFilter", v-model="course")

            spacer(:height="8")
            // score
            div
                h4(style="display: inline-block; width: 170px") 我获得的分数：
                input(type="text", style=inputStyle, v-model="score")

            spacer(:height="24")
            divider
            spacer(:height="24")

            // tags
            h4 标签：
            spacer(:height="16")
            div(style="border-left: 2px solid #123456; display: flex; flex-wrap: wrap; padding-left: 4px;")
                span(v-for="(item, index) in info.tags", :key="index", style=tagStyle,
                    @click="onTagClick(index)",
                    :style="selectedTags.indexOf(index) >= 0 ? selectedStyle : {}") {{ item.tName }}

            spacer(:height="24")
            divider
            spacer(:height="24")

            h4 选项：
            spacer(:height="16")

            // take again
            my-check(v-model="takeAgain") 如果重来我还会再选
            spacer(:height="8")

            // attendance
            my-check(v-model="attendance") 上课会点名

            spacer(:height="24")
            divider
            spacer(:height="24")

            // comment
            h4 评价：
            spacer(:height="16")
            textarea(style="width: 100%; resize: none; height: 100px; padding: 8px; box-sizing: border-box; background: ghostwhite; border: none",
                placeholder=hint, v-model="comment")

            spacer(:height="64")

            // buttons
            div(style=buttonStyle)
                button2(:width="100", :height="32", color="#123456", hover-color="#123456aa",
                    @click="onConfirm", style="margin-right: 16px") 发表
                button2(:width="100", :height="32", color="#123456", hover-color="#123456aa",
                    @click="onCancel()") 取消
</template>

<script>
    import Stars from "@/components/base/Stars";
    import Button2 from "@/components/base/button/Button2";
    import MyCheck from "@/components/base/MyCheck";
    import MyCombo from "@/components/base/MyCombo";
    import LoadingBox from "@/components/base/idler/LoadingBox";
    import Spacer from "@/components/base/layout/Spacer";
    import Divider from "@/components/base/layout/Divider";
    import InfoDialog from "@/components/base/dialogs/InfoDialog";

    export default {
        name: "CommentPage",
        components: {Stars, Button2, MyCheck, MyCombo, LoadingBox, Spacer, Divider, InfoDialog},
        data: function () {
            return {
                info: {
                    name: "NAME",
                    tags: ["tag1", "tag2", "tag3"],
                    courses: ["course1", "course2", "course3"],
                },
                selectedTags: [],
                quality: 1,
                difficulty: 1,
                comment: "",
                takeAgain: false,
                attendance: false,
                score: "",
                course: -1,

                loading: true,
                loadSuccess: false,
                errorInfo: "",

                selectedStyle: {
                    background: "#123456",
                    color: "white"
                },

                showDialog: false,
                dialogIcon: "times",
                dialogText: "info",
                dialogIconColor: "black",
            }
        },
        created: function () {
            let domain = this.global.domain;
            let prefix = this.global.prefix;
            let pid = this.$route.params.pid;

            this.loadSuccess = true;
            this.loading = true;

            let promise1 = this.axios.get(`http://${domain}/${prefix}professors/${pid}`).then((response) => {
                if (response.data.code !== 0) {
                    this.loadSuccess = false;
                    this.errorInfo = "无法获取教师信息:" + response.data.msg;
                    return;
                }

                let data = response.data.data;

                this.info.name = data.professorInfo.pLastName + data.professorInfo.pFirstName;
            });
            let promise2 = this.axios.get(`http://${domain}/${prefix}courses?pId=${pid}`).then((response) => {
                if (response.data.code !== 0) {
                    this.loadSuccess = false;
                    this.errorInfo = "无法获取课程信息:" + response.data.msg;
                    return;
                }

                let data = response.data.data;

                this.info.courses = data.courseInfo;
            });
            let promise3 = this.axios.get(`http://${domain}/${prefix}tags`).then((response) => {
                if (response.data.code !== 0) {
                    this.loadSuccess = false;
                    this.errorInfo = "无法获取标签信息:" + response.data.msg;
                    return;
                }

                let data = response.data.data;

                this.info.tags = data.tTags;
            });

            Promise.all([promise1, promise2, promise3]).then(() => {
                this.loading = false;
            })
        },
        methods: {
            async showMessage(icon, text, iconColor) {
                this.dialogIcon = icon;
                this.dialogText = text;
                this.showDialog = true;
                this.dialogIconColor = iconColor || "black";
                
                await new Promise((resolve) => {
                    setTimeout(() => {
                        this.showDialog = false;
                        resolve();
                    }, 2000);
                })
            },
            onTagClick(index) {
                // window.console.log(name, index);
                let idx = this.selectedTags.indexOf(index);
                if (idx >= 0) {
                    this.selectedTags.splice(idx, 1);
                } else {
                    this.selectedTags.push(index);
                }
            },
            onCancel () {
                this.$router.go(-1);
            },
            onConfirm () {
                if ((this.score < 0 || this.score > 100) && this.score !== "") {
                    this.showMessage("exclamation-triangle", "分数必需在0到100之间, 或者为空", "red");
                    return;
                }
                if (this.course < 0 || this.course >= this.info.courses.length) {
                    this.showMessage("exclamation-triangle", "非法的课程信息", "red");
                    return;
                }
                if (this.comment === "") {
                    this.showMessage("exclamation-triangle", "评论不能为空", "red");
                    return;
                }

                let postData = {
                    rCourse: this.info.courses[this.course].cId,
                    rProfessor: this.$route.params.pid,
                    rQuality: this.quality,
                    rDifficulty: this.difficulty,
                    rTakeAgain: this.takeAgain,
                    rAttendance: this.attendance,
                    rGradeReceived: this.score,
                    rTags: this.selectedTags.map((value) => {
                        return this.info.tags[value].tId;
                    }),
                    rComment: this.comment,
                };

                window.console.log(postData);

                this.axios.post(`http://${this.global.domain}/${this.global.prefix}ratings`, postData)
                    .then((response) => {
                        if (response.data.code === 0) {
                            this.showMessage("check", "评论成功, 即将跳转", "green");
                            setTimeout(() => {
                                this.$router.go(-1);
                            }, 2000);
                        } else {
                            if (response.data.code === 2000) {
                                this.showMessage("exclamation-triangle", "会话无效, 请重新登录", "red")
                                    .then(() => {
                                        this.$router.replace("/");
                                    });
                            } else {
                                this.showMessage("exclamation-triangle", response.data.msg, "red");
                            }
                        }
                    })
            }
        },
        filters: {
            courseFilter: function (data) {
                return data.map((value) => {
                    return value.cName;
                });
            }
        }
    }
</script>

<style scoped>

</style>