<template>
    <div>
        <EnterSection v-if="showEnterDlg"
                      @close="showEnterDlg = false"
        ></EnterSection>
        <div id="top-bar">
            <p id="intro"><span style="font-size: 1.5em">R</span>ate <span style="font-size: 1.5em">M</span>y <span style="font-size: 1.5em">P</span>rofessor!</p>
            <IconButton style="float: right"
                        :height="96"
                        :width="96"
                        :fontsize="1.8"
                        icon-name="sign-in-alt"
                        hover-icon-color="white"
                        @click="onLoginClicked"
            ></IconButton>
            <HorizontalMenu height="96px"
                            style="display: inline-block; float: right"
                            :items="['GITHUB', 'ABOUT', 'DONATE']"
                            @click="onTopBarClicked"
            ></HorizontalMenu>

        </div>
        <div id="front-page-body">
            <img src="../../assets/logo.png" />
            <p>Rate My Professors</p>
            <p style="margin-top: 16px">An
                <span style="background: lightsalmon; border-radius: 7px; color: white; padding: 0 5px">easy</span>
                to use,
                <span style="background: lightskyblue; border-radius: 7px; color: white; padding: 0 5px">entertaining</span>, and
                <span style="background: lightpink; border-radius: 7px; color: white; padding: 0 5px">magic</span>
                Website!
            </p>
            <Button2 style="padding: 8px 16px; border-radius: 5px; margin-top: 100px; box-shadow: 0 10px 20px 1px black"
                     color="#283539"
                     hover-icon-color="white"
                     :height="64"
                     :width="200"
                     @click="onLoginClicked"
            >Get Started >></Button2>
        </div>
    </div>
</template>

<script>
    import HorizontalMenu from "@/components/base/menu/HorizontalMenu";
    import IconButton from "@/components/base/button/IconButton";
    import Button2 from "@/components/base/button/Button2";
    import EnterSection from "@/components/front-page/EnterSection";
    // import Button from "@/components/base/Button";

    export default {
        name: "FrontPage",
        components: {EnterSection, Button2, IconButton, HorizontalMenu},
        methods: {
            onLoginClicked: function () {
                // window.console.log("aaa");

                this.showEnterDlg = true;
            },
            onTopBarClicked: function (index, caption) {
                // window.console.log(index, caption);

                if (caption === "GITHUB") {
                    window.open("https://github.com/IATOW/rate-my-professors", "_blank");
                }
            }
        },
        data: function () {
            return {
                showEnterDlg: false
            }
        }
    }
</script>

<style scoped>
    #top-bar {
        height: 96px;
        background: #283539;
    }

    #top-bar #intro {
        font-family: "cutoff", sans-serif;
        text-transform: uppercase;
        height: 96px;
        line-height: 96px;
        color: white;
        font-size: 1.7em;
        margin-left: 24px;
        display: inline-block;
    }

    #front-page-body {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        width: 100%;
    }

    #front-page-body img {
        margin-top: 32px;
    }

    #front-page-body p {
        font-size: 1.6em;
        letter-spacing: 2px;
        /*font-family: ;*/
    }
</style>