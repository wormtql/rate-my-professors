<template>
    <div :style="rootStyle">
        <h1 style="text-align: center; margin-top: 16px; background: black; color: white; padding: 0 8px; z-index: 1;">注册</h1>
        <h4 style="text-align: center; margin-bottom: 32px; margin-top: 8px; color: #CC33CC">加入Rate My Professor</h4>

        <MyInput2 ph="邮箱" style="margin-bottom: 32px" icon-name="envelope"
            v-model="email" :error="emailError"></MyInput2>
        <MyInput2 ph="姓名" style="margin-bottom: 32px" icon-name="address-card"
            v-model="username"></MyInput2>
<!--        <MyInput2 ph="名" style="margin-bottom: 20px"></MyInput2>-->
        <MyInput2 ph="密码" pwd style="margin-bottom: 32px" icon-name="lock"
            v-model="password"></MyInput2>
        <MyInput2 ph="确认密码" pwd style="margin-bottom: 32px" icon-name="lock"
            v-model="confirmPassword" :error="passwordError"></MyInput2>

        <Button2 :height="48" color="#123456" hoverColor="#456789"
            @click="onConfirmClick"
        >注册</Button2>

        <linear-idler v-if="showIdle"></linear-idler>

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
    import MyInput2 from "@/components/base/input/MyInput2";
    import Button2 from "@/components/base/button/Button2";
    import LinearIdler from "@/components/base/idler/LinearIdler";

    export default {
        name: "SignUpSection",
        components: {MyInput2, Button2, LinearIdler},
        data: function () {
            return {
                email: "",
                username: "",
                password: "",
                confirmPassword: "",
                showIdle: false,
                errorInfo: "",
            }
        },
        computed: {
            rootStyle: function () {
                return {
                    display: "flex",
                    alignItems: "center",
                    // justifyContent: "center",
                    flexDirection: "column",
                    height: "550px",
                    position: "relative",
                    // overflow: "auto"
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
            },
            emailError: function () {
                let reg = /^([a-zA-Z]|[0-9])(\w)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;
                if (!reg.test(this.email) && this.email !== "") {
                    return "邮箱格式错误"
                } else {
                    return ""
                }
            },
            passwordError: function () {
                if (this.password === this.confirmPassword) {
                    return ""
                } else {
                    return "密码不一致"
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
                if (this.email === "" || this.emailError) {
                    this.setError("邮箱错误或者为空");
                    return;
                }
                if (this.password === "") {
                    this.setError("密码不能为空");
                    return;
                }
                if (this.passwordError) {
                    this.setError("密码不一致");
                    return;
                }
                if (this.username === "") {
                    this.setError("用户名不能为空");
                    return;
                }

                this.showIdle = true;

                let data = {
                    uEmail: this.email,
                    uPassword: this.password,
                    uFirstName: this.username,
                    uLastName: ""
                };

                // window.console.log(data);
                // window.console.log(`${this.global.domain}`);

                this.axios.post(`http://${this.global.domain}/users`, data).then((response) => {
                    if (response.data.code === 0) {
                        // todo login
                        data = {
                            uEmail: data.uEmail,
                            uPassword: data.uPassword
                        };
                        this.axios.post(`http://${this.global.domain}/sessions`, data).then((res) => {
                            if (res.data.code === 0) {
                                this.$router.push("/rate");
                            } else {
                                this.setError(res.data.msg);
                            }
                        })
                    } else {
                        this.setError(response.data.msg);
                    }

                    this.showIdle = false;

                });
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