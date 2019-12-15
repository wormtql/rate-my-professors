<template lang="pug">
    -
        let color = "gray";
        let color2 = "#FF336655";

        let tagStyle = `
            // background: #00000012;
            display: inline-flex;
            align-items: center;
            // border-radius: 1000px;
            padding: 2px 4px;
            font-size: 0.8em;
            margin-right: 16px;
            margin-bottom: 12px;
            border-bottom: 2px solid #123456;
        `;
        let tagSpan2Style = `
            height: 14px;
            // border-radius: 1000px;
            background: #123456;
            // width: 18px;
            padding: 2px 8px;
            text-align: center;
            display: inline-block;
            line-height: 14px;
            margin-left: 8px;
            color: white;
            // font-size: 0.8em;
        `


    div(:style="rootStyle")
        // avatar, name, school, department
        div(style="padding-bottom: 16px; margin-bottom: 24px; border-bottom: 1px solid #00000022")
            img.avatar(src="../../../assets/logo.png", :style="basicInfoImgStyle")
            div(:style="basicInfoDesStyle")
                h1 {{ info.name }}
                h3(style="color: darkgray") {{ info.schoolName }}
                h3(style="color: darkgray") {{ info.department }}

        // tags
        div(style="padding-bottom: 24px; border-bottom: 1px solid #00000022; margin-bottom: 24px;")
            div(v-if="pTags.length === 0")
                p 这个老师还没有标签
            div(v-if="pTags.length > 0")
                div(v-for="(item, index) in pTags", :key="index", style=tagStyle)
                    span {{ item.tName }}
                    span(style=tagSpan2Style) {{ item.tNumber }}

        // statistics
        div(style="display: flex; align-items: center")
            idk(:frac="this.info.rate / 10", tooltip="总分", :text="this.info.rate.toString()",
                color="#ffaa00")
            idk(:frac="this.info.difficulty / 10", tooltip="难度", :text="this.info.difficulty.toString()",
                style="margin: 0 32px", color="#ffaa00")
            idk(:frac="this.info.wouldTakeAgain", tooltip="是否会再选", color="#ffaa00",
                :text="(this.info.wouldTakeAgain * 100).toString() + '%'")


        // detailed information
        div(style="border-top: 1px solid #00000022; margin-top: 24px; padding: 16px 0;")
            div(style="padding: 8px 0")
                span(style="color: gray; width: 100px; display: inline-block") 学校省份
                span(style="float: right") {{ info.province }}
            div(style="padding: 8px 0")
                span(style="color: gray; width: 100px; display: inline-block") 学校城市
                span(style="float: right") {{ info.city }}
            div(style="padding: 8px 0")
                span(style="color: gray; width: 100px; display: inline-block") 学校网址
                a(style="float: right; text-decoration: none; color: black", :href="info.website") {{ info.website }}

        // comment section
        comment-box(v-if="showDlg", @cancel="showDlg = false", @comment="onComment",
            :info="commentInfo")

        //- info-dialog
        

        // comments
        div(style="margin-bottom: 100px")
            div(style="margin: 16px 0")
                h3(style="display: inline-block") 评论（{{ commentAmount > 999 ? "999+" : commentAmount }}）
                icon-button(icon-color="black", icon-name="edit", :height="32", :width="32", :margin="4", hover-icon-color="gray",
                    @click="showDlg = true")

            pager(:value="currentPage", style="margin-bottom: 8px;",
                :total="Math.ceil(commentAmount / 10.0)",
                @navigate="onNavigate")

            div(style="width: 100%; display: flex; align-items: center; justify-content: center; height: 200px;",
                v-if="loadingComment")
                h3(style="margin-right: 24px;") 加载中...
                loading-box
            div(v-if="!loadingComment")
                div(v-if="ratingsInfo.length === 0")
                    p(style="padding: 8px 0;") 快来抢沙发:)
                div(v-if="ratingsInfo.length > 0")
                    comment-item(v-for="(item, index) in ratingsInfo", :key="index", :data="item",
                        style="padding: 16px 0; border-bottom: 1px solid #00000011")
</template>

<script>
    import IconButton from "@/components/base/button/IconButton";
    import CommentItem from "@/components/main-page/accessory/CommentItem";
    import Button1 from "@/components/base/button/Button2";
    import MultiTagBox from "@/components/base/MultiTagBox";
    import Pager from "@/components/base/Pager";
    import LabelButton from "@/components/base/button/LabelButton";
    import Stars from "@/components/base/Stars";
    import MyCheck from "@/components/base/MyCheck";
    import CommentBox from "@/components/main-page/accessory/CommentBox";
    import Idk from "@/components/base/Idk";
    import LoadingBox from "@/components/base/idler/LoadingBox";
    import InfoDialog from "@/components/base/dialogs/InfoDialog";

    export default {
        name: "TeacherInfo",
        components: {
            LoadingBox,
            Idk,
            CommentBox,
            MyCheck, Stars, LabelButton, Pager, MultiTagBox, Button1, CommentItem, IconButton,
            InfoDialog},
        data: function () {
            return {
                info: {
                    rate: 8.5,
                    name: "teacher",
                    schoolName: "school",
                    difficulty: 6.7,
                    wouldTakeAgain: 0.8,
                    province: "province",
                    city: "city",
                    website: "https://www.baidu.com",
                    department: "depart",
                },
                // quality: 0,
                showDlg: false,
                courseInfo: [],
                tags: [],
                pTags: [],

                loadingComment: true,
                rawRatingInfo: [],

                commentAmount: 999,

                currentPage: 1
            }
        },
        created: function () {
            let teacherId = this.$route.params.pid;

            // load professor info
            this.axios.get(`http://${this.global.domain}/${this.global.prefix}professors/${teacherId}`).then((response) => {
                window.console.log("professor info", response.data);

                let data = response.data.data;

                this.info.rate = data.professorInfo.pOverallQuality.toFixed(2);
                this.info.name = data.professorInfo.pLastName + " " + data.professorInfo.pFirstName;
                this.info.schoolName = data.professorInfo.pSchoolName;
                this.info.difficulty = data.professorInfo.pLevelOfDifficulty.toFixed(2);
                this.info.wouldTakeAgain = parseFloat(data.professorInfo.pWouldTakeAgain.split("%")[0]).toFixed(1) / 100;
                this.info.province = data.professorInfo.pSchoolState;
                this.info.city = data.professorInfo.pSchoolCity;
                this.info.website = data.professorInfo.pSchoolWebsite;
                this.info.department = data.professorInfo.pDepartment;
            });

            // load course info
            this.axios.get(`http://${this.global.domain}/${this.global.prefix}courses?pId=${teacherId}`).then((response) => {
                window.console.log("course info", response.data);

                this.courseInfo = response.data.data.courseInfo;

                // window.console.log(this.courseInfo);
            });

            // load tags
            this.axios.get(`http://${this.global.domain}/${this.global.prefix}tags`).then((response) => {
                window.console.log("tags", response.data);
                if (response.data.code === 0) {
                    this.tags = response.data.data.tTags;
                }
            });

            // load professor tags
            this.axios.get(`http://${this.global.domain}/${this.global.prefix}tags?pId=${teacherId}`).then((response) => {
                window.console.log("pTags", response.data);
                if (response.data.code === 0) {
                    this.pTags = response.data.data.tTags;
                }
            })

            // get comment amount
            this.getCommentNumber().then((num) => {
                this.commentAmount = num;
            })

            // load page 1 comments
            this.loadRatingInfo(0).then(() => {
                this.loadingComment = false;
            })
        },
        methods: {
            getCommentNumber: async function () {
                let pid = this.$route.params.pid;
                let domain = this.global.domain;
                let prefix = this.global.prefix;
                let ans = 999;
                await this.axios.get(`http://${domain}/${prefix}ratings?pId=${pid}&offset=0&limit=10`)
                    .then((response) => {
                        if (response.data.code === 0) {
                            this.rawRatingInfo = response.data.data.ratings;
                            ans = response.data.data.total;
                        }
                    });

                return ans;
            },
            loadRatingInfo: async function (page) {
                let pid = this.$route.params.pid;
                let domain = this.global.domain;
                await this.axios.get(`http://${domain}/${this.global.prefix}ratings?pId=${pid}&offset=${page*10}&limit=10`)
                    .then((response) => {
                        if (response.data.code === 0) {
                            this.rawRatingInfo = response.data.data.ratings;
                        }
                    });
            },
            onNavigate: function (to) {
                // window.console.log(to);
                this.currentPage = to;

                this.loadingComment = true;
                this.loadRatingInfo(to - 1).then(() => {
                    this.loadingComment = false;
                })
            },
            onComment: function (data) {
                this.showDlg = false;
                // window.console.log(data);
                let vm = this;

                let postData = {
                    rCourse: this.courseInfo[data.course].cId,
                    rProfessor: this.$route.params.pid,
                    rQuality: data.quality,
                    rDifficulty: data.difficulty,
                    rTakeAgain: data.takeAgain,
                    rAttendance: data.attendance,
                    rGradeReceived: data.score,
                    rTags: data.tags.map(function (value) {
                        return vm.tags[value].tId;
                    }),
                    rComment: data.comment,
                };

                window.console.log(postData);

                this.axios.post(`http://${this.global.domain}/${this.global.prefix}ratings`, postData);
            }
        },
        computed: {
            ratingsInfo: function () {
                return this.rawRatingInfo.map(function(value) {
                    return {
                        course: value.rClass,
                        quality: value.rQuality,
                        difficulty: value.rDifficulty,
                        takeAgain: null,
                        attendance: value.rAttendance,
                        grade: value.rGradeReceived,
                        tags: value.rTags,
                        comment: value.rComment,
                        positive: value.rPeopleFoundUseful,
                        negative: value.rPeopleDidNotFoundUseful,
                        date: value.rDate,
                    }
                });
            },
            // values for comment box
            commentInfo: function () {
                let data = {
                    tags: this.tags.map(function (value) {
                        return value.tName
                    }),
                    name: this.info.name,
                    courses: this.courseInfo.map(function (value) {
                        return value.cName
                    }),
                }

                // window.console.log("comment data: ", data);
                return data;
            },
            scoreComment: function () {
                let ans = "";
                if (this.info.rate < 3.0) {
                    ans = "这个老师看起来不太好";
                } else if (this.info.rate >= 3.0 && this.info.rate < 4) {
                    ans = "这个老师还行";
                } else if (this.info.rate >= 4) {
                    ans = "这个老师很好";
                }

                return ans;
            },
            rootStyle: function () {
                return {
                    padding: "64px 300px 0 300px"
                }
            },
            basicInfoDesStyle: function () {
                return {
                    display: "inline-flex",
                    height: "128px",
                    verticalAlign: "top",
                    justifyContent: "center",
                    flexDirection: "column",
                    paddingLeft: "32px",
                    borderLeft: "5px solid black"
                }
            },
            basicInfoImgStyle: function () {
                return {
                    borderRadius: "50%",
                    height: "128px",
                    width: "128px",
                    boxShadow: "0 0 40px 0 gray",
                    marginRight: "32px"
                }
            },
            scoreStyle: function () {
                return {
                    // display: "flex",
                    alignItems: "center"
                }
            }
        }
    }
</script>

<style scoped lang="scss">
/*div{*/
/*    justify-content: space-between;*/
/*}*/
</style>