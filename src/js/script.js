function updateForm() {
    var idOperateur = document.getElementById('idOperateurJson');
    var json = idOperateur.value;

    if (json) {
        try {
            var row = JSON.parse(json);
            document.getElementById('nom').placeholder = "Nom : " + row.nom;
            document.getElementById('adresse').placeholder = "Adresse : " + row.adresse;
            document.getElementById('telephone').placeholder = "Telephone : "  + row.telephone;
            document.getElementById('tarifAbonne').placeholder = "Tarif abonné : " + row.tarifAbonne;
            document.getElementById('tarifNonAbonne').placeholder = "Tarif non abonné : " + row.tarifNonAbonne;
        } catch (e) {
            console.error('Erreur dans la lecture du JSON', e);
        }
    } 
}