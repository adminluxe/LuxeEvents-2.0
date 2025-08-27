import { MapContainer, TileLayer, Marker, Popup } from "react-leaflet";
import "leaflet/dist/leaflet.css";
import L from "leaflet";
import { eventsData } from "@/data/eventsData";
const icon = new L.Icon({
  iconUrl:"https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon.png",
  iconRetinaUrl:"https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon-2x.png",
  shadowUrl:"https://unpkg.com/leaflet@1.9.4/dist/images/marker-shadow.png",
  iconSize:[25,41], iconAnchor:[12,41]
});
export default function Map(){
  const center=[50.8503,4.3517];
  return (
    <div className="w-full h-[420px] rounded-2xl overflow-hidden shadow-lg">
      <MapContainer center={center} zoom={7} className="w-full h-full">
        <TileLayer attribution="&copy; OpenStreetMap" url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" />
        {eventsData.map(ev=>(
          <Marker key={ev.id} position={[ev.lat,ev.lng]} icon={icon}>
            <Popup><strong>{ev.title}</strong><br/><small>{new Date(ev.date).toLocaleDateString()}</small><br/>{ev.description}</Popup>
          </Marker>
        ))}
      </MapContainer>
    </div>
  );
}
