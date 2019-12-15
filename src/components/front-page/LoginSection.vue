<template>
    <div :style="rootStyle"> 
        <h1 style="text-align: center; margin-top: 16px; background: black; color: white; padding: 0 8px; z-index: 1">登录</h1>
        <h4 style="text-align: center; margin-bottom: 32px; margin-top: 8px; color: #CC33CC; z-index: 1">开始您的Rating体验</h4>

        <MyInput2 style="margin-bottom: 32px" ph="邮箱" v-model="email"
            :error="emailError"></MyInput2>

        <MyInput2 style="margin-bottom: 32px" pwd ph="密码" icon-name="lock" v-model="password"></MyInput2>

        <div style="width: 100%; margin-bottom: 32px">
            <my-check v-model="rememberMe">
                下次自动登录
            </my-check>
        </div>

        <Button2 :height="48" color="#123456" hoverColor="#456789"
            @click="onConfirmClick"
        >登录</Button2>
        <linear-idler v-show="showIdle"></linear-idler>

        <transition name="fade">
            <div v-if="this.errorInfo"
                :style="errorStyle"
            >
                <v-icon name="exclamation-circle" style="margin-right: 8px"></v-icon>
                {{ errorInfo }}
            </div>
        </transition>

        
    </div>
</template>

<script>
    import MyCheck from "@/components/base/MyCheck";
    import MyInput2 from "@/components/base/input/MyInput2";
    import Button2 from "@/components/base/button/Button2";
    import LinearIdler from "@/components/base/idler/LinearIdler";

    export default {
        name: "LoginSection",
        components: {MyInput2, MyCheck, Button2, LinearIdler},
        computed: {
            rootStyle: function () {
                return {
                    display: "flex",
                    alignItems: "center",
                    flexDirection: "column",
                    width: "100%",
                    position: "relative",
                    height: "500px"
                }
            },
            emailError: function () {
                let reg = /^([a-zA-Z]|[0-9])(\w)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;
                if (!reg.test(this.email) && this.email !== "") {
                    return "邮箱格式错误"
                } else {
                    return ""
                }
            },
            errorStyle: function () {
                return {
                    background: "#f3002177",
                    width: "100%",
                    padding: "4px 8px",
                    boxSizing: "border-box",
                    color: "white",
                    display: "flex",
                    alignItems: "center",
                    position: "absolute",
                    bottom: "0"
                }
            }
        },
        methods: {
            setError: function (info) {
                if (info) {
                    this.errorInfo = info;
                    setTimeout(() => {
                        this.errorInfo = "";
                    }, 2000);
                } else {
                    this.errorInfo = "";
                }
            },
            onConfirmClick: function () {
                let data = {
                    uEmail: this.email,
                    uPassword: this.password,
                };

                if (this.emailError || this.email === "") {
                    this.setError("邮箱错误或者为空");
                    return;
                }
                if (this.password === "") {
                    this.setError("密码不能为空");
                    return;
                }

                this.showIdle = true;

                let vm = this;
                this.axios.post(`http://${this.global.domain}/${this.global.prefix}sessions`, data).then(function (response) {
                    window.console.log(response);

                    // vm.axios.get(`http://${vm.global.domain}/users`).then(window.console.log);

                    if (response.data.code === 0) {
                        vm.$router.push("/rate");
                    } else {
                        vm.setError(response.data.msg);
                    }

                    vm.showIdle = false;

                }).catch(window.console.log);

                // this.$cookies.set("email", this.email);
                // this.$router.push("/rate");
            }
        },
        data: function () {
            return {
                email: "",
                password: "",
                rememberMe: false,
                showIdle: false,
                errorInfo: ""
            }
        }
    }
</script>

<style scoped>
.fade-enter-active, .fade-leave-active {
    transition: opacity, 300ms;
}

.fade-enter, .fade-leave-to {
    opacity: 0;
    transform: translateY(16px);
}
</style>