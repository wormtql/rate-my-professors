<template>
    <div>
<!--        top bar-->
        <div :style="topBarStyle">
            <p :style="topBarLogoStyle">
                <span style="font-size: 1.5em">R</span>ate
                <span style="font-size: 1.5em">M</span>y
                <span style="font-size: 1.5em">P</span>rofessor!
            </p>
            <div id="user-info"
                 @click="userPopupMenuShow = !userPopupMenuShow"
            >
                <img src="../../assets/logo.png" />
                <p>{{ username }}</p>
            </div>
            <PopupMenu :style="userMenuStyle"
                       v-show="userPopupMenuShow"
                       :items="userMenu"
                       @click="onUserMenuClicked"
            ></PopupMenu>
        </div>

        <div :style="{height: 'calc(100% - ' + this.topBarHeight.toString() + 'px)'}">
<!--            side bar-->
            <div :style="sideBarStyle">
                <IconTextButton v-for="(item, index) in menu"
                                :key="index"
                                :icon="item.icon"
                                @click="onMenuClicked(item.name, index)"
                                color="white"
                >{{ item.caption }}</IconTextButton>
            </div>

            <div :style="bodyStyle">
                <router-view></router-view>
            </div>

        </div>
    </div>
</template>

<script>
    import IconTextButton from "@/components/base/button/IconTextButton";
    import PopupMenu from "@/components/base/menu/PopupMenu";
    export default {
        name: "MainPage",
        components: {PopupMenu, IconTextButton},
        computed: {
            topBarStyle: function () {
                return {
                    height: this.topBarHeight.toString() + "px",
                    width: "100%",
                    background: "#283539",
                }
            },
            topBarLogoStyle: function () {
                return {
                    fontFamily: "cutoff",
                    fontSize: "1.7em",
                    height: this.topBarHeight.toString() + "px",
                    lineHeight: this.topBarHeight.toString() + "px",
                    color: "white",
                    marginLeft: "24px",
                    display: "inline-block"
                }
            },
            sideBarStyle: function () {
                return {
                    height: "100%",
                    display: "inline-block",
                    width: this.sideBarWidth.toString() + "px",
                    background: "rgb(30, 43, 47)",
                    // background: "black",
                    position: "relative",
                    borderRight: "1px solid #11111122",
                    boxSizing: "border-box"
                }
            },
            userMenuStyle: function () {
                return {
                    position: "absolute",
                    right: "0",
                    top: (this.topBarHeight).toString() + "px"
                }
            },
            bodyStyle: function () {
                return {
                    display: "inline-block",
                    height: "100%",
                    width: "calc(100% - " + this.sideBarWidth.toString() + "px)",
                    verticalAlign: "top",
                    overflow: "auto"
                }
            }
        },
        data: function () {
            return {
                username: "",
                topBarHeight: 96,
                sideBarWidth: 96,
                menu: [
                    {
                        caption: "主页",
                        name: "home",
                        icon: "home"
                    },
                    {
                        caption: "测试",
                        name: "test",
                        icon: "graduation-cap"
                    },
                    {
                        caption: "搜索",
                        name: "search",
                        icon: "search"
                    }
                    // {
                    //     caption: "找文章",
                    //     name: "searchBlog",
                    //     icon: "sticky-note"
                    // }
                ],
                userPopupMenuShow: false,
                userMenu: [
                    {
                        name: "center",
                        caption: "个人中心",
                        icon: "info-circle"
                    },
                    {
                        name: "exit",
                        caption: "退出登录",
                        icon: "sign-out-alt"
                    }
                ]
            }
        },
        methods: {
            onMenuClicked: function (name, index) {
                if (name === "home") {
                    this.$router.replace("/rate/home");
                } else if (name === "test") {
                    this.$router.replace("/rate/teacher-info-test/qdUKKBcasm");
                } else if (name === "search") {
                    this.$router.replace("/rate/find-teacher");
                }
                window.console.log(name, index)
            },
            onUserMenuClicked: function (name, index) {
                window.console.log(name, index)
            }
        },
        created: function () {
            this.username = this.$cookies.get("email")
        }
    }
</script>

<style scoped>
    #user-info {
        float: right;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100%;
        padding: 0 24px;
    }

    #user-info img {
        width: 64px;
        height: 64px;
        border-radius: 50%;
        margin-right: 16px;
    }

    #user-info p {
        display: inline-block;
        color: white;
        vertical-align: center;
        letter-spacing: 2px;
        font-size: 1.2em;
    }

    #user-info:hover {
        background: dimgray;
    }
</style>