{{flutter_js}}
{{flutter_build_config}}

const loading = document.createElement('div');

loading.style.position = 'fixed';
loading.style.top = '50%';
loading.style.left = '50%';
loading.style.transform = 'translate(-50%, -50%)';
loading.style.color = '#000';
loading.style.textAlign = 'center';
loading.style.backgroundColor = 'rgba(255, 255, 255, 0.8)';
loading.style.padding = '20px';
loading.style.borderRadius = '10px';
loading.style.boxShadow = '0px 4px 10px rgba(0, 0, 0, 0.1)';
document.body.appendChild(loading);

function setLoading(hearts) {
    loading.innerHTML =
        '<div style="font-size: clamp(24px, 5vw, 48px);">조금만 기다려주세요!</div>' +
        '<div style="font-size: clamp(20px, 4vw, 40px); margin-top: 8px;">' + hearts + '</div>';
}

setLoading('❤️');

_flutter.loader.load({
    onEntrypointLoaded: async function(engineInitializer) {
        setLoading('❤️❤️');
        const appRunner = await engineInitializer.initializeEngine({
            useColorEmoji: true,
            renderer: "canvaskit",
        });

        setLoading('❤️❤️❤️');
        await appRunner.runApp();

        loading.remove();
    }
});
