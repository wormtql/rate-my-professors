<template>
    <div :style="rootStyle">

        <div v-if="loaded" style="padding-bottom: 32px;">
            <h1 style="font-size: 3em; border-left: 5px solid #123456; padding-left: 16px; color: #123456; \
                display: inline-block;
            "
            
            >早上好, {{ username }}</h1>
            <!-- <img src="../../assets/logo.png" width="128px" height="128px"
                style="border-radius: 50%; box-shadow: 0 0 40px 1px #00000055; display:inline-block"
             /> -->
            <div style="display: flex; align-items: center; font-size: 1.2em; margin-top: 24px;">
                <v-icon name="envelope"></v-icon>
                <p style="margin-left: 8px;"> {{ email }} </p>
            </div>
            
        </div>
        <p :style="headerStyle">工具箱</p>
        <Card header="个人中心"
              description="修改，维护个人信息"
              color="#ffaa0011"
              img="note.svg"
        ></Card>
        <Card header="找教师"
              description="寻找教师，并为他打CALL"
              color="#ff0d0011"
              img="cooperate.svg"
              @click="$router.replace('/rate/find-teacher')"
        ></Card>
    </div>
</template>

<script>
    import Card from "@/components/main-page/accessory/Card";
    export default {
        name: "HomePage",
        components: {Card},
        computed: {
            rootStyle: function () {
                return {
                    padding: "80px 300px 100px 300px",
                    // overflow: "auto"
                }
            },
            headerStyle: function () {
                return {
                    fontSize: "2em",
                    borderBottom: "4px solid lightblue"
                }
            }
        },
        data: function () {
            return {
                username: "",
                email: "",
                loaded: false
            }
        },
        created: function () {
            window.console.log("aaa");
            this.axios.get(`http://${this.global.domain}/users`).then((res) => {
                if (res.data.code === 0) {
                    this.loaded = true;

                    let info = res.data.data.userInfo;
                    // window.console.log(res.data);

                    this.username = info.uFirstName + info.uLastName;
                    this.email = info.uEmail;
                }
            })
        }
    }
</script>

<style scoped>

</style>