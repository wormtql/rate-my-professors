<template lang="pug">
    div(:style="rootStyle")
        div.linear-idler(:style="itemStyle")
</template>

<script>
export default {
    name: "LinearIdler",
    props: {
        height: {
            type: Number,
            default: 5
        },
        width: {
            type: Number,
            default: -1
        },
    },
    computed: {
        rootStyle: function () {
            return {
                height: `${this.height}px`,
                width: this.width <= 0 ? "100%" : `${this.width}px`,
                display: "inline-block",
                position: "relative",
                background: "#00000022"
            };
        },
        itemStyle: function () {
            return {
                height: `${this.height}px`,
                position: "absolute",
                // left: "0",
                // top: "0",
                display: "inline-block",
                width: "50%"
            }
        }
    }
}
</script>

<style scoped>

@keyframes linear-idler-animation {
    0% {
        left: 0;
        /* width: 20%; */
        top: 0;
        
        background: #00b0ff;
    }
    50% {
        left: 100%;
        transform: translateX(-100%);
        background: #8c75f6;
    }
    100% {
        left: 0;
        /* width: 20%; */
        background: #00b0ff;
    }
}

.linear-idler {
    animation: linear-idler-animation 2s linear infinite;
}

</style>