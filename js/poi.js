// Association des types aux icônes
const icons = {
    "Boss": red,
    "Run&Gun": gre,
    "PNJ": blu
};

// Fonction de récupération des POI
async function loadPOI() {
    try {
        const response = await fetch("api/poi.php?map_id=1");

        if (!response.ok) {
            throw new Error("Erreur HTTP : " + response.status);
        }

        const pois = await response.json();

        if (!Array.isArray(pois)) {
            throw new Error("La réponse PHP n'est pas une liste de POI.");
        }

        pois.forEach(poi => {
            const icon = icons[poi.type_name];

            if (!icon) {
                console.warn("Type inconnu :", poi.type_name);
                return;
            }

            const marker = L.marker(
                [
                    h - Number(poi.position_Y),
                    Number(poi.position_X)
                ],
                { icon: icon }
            ).addTo(map);

            marker.bindPopup(`
                <b>${poi.name}</b>
                <p>${poi.description ?? ""}</p>
                <small>${poi.zone_name ?? ""}</small>
            `);

            marker.on("mouseover", function () {
                this.openPopup();
            });

            marker.on("mouseout", function () {
                this.closePopup();
            });
        });

        console.log(pois.length + " POI chargés !");

    } catch (error) {
        console.error("Impossible de charger les POI :", error);
    }
}

// Chargement des POI
loadPOI();