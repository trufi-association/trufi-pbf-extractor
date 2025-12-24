# Trufi PBF Extractor

Extract OpenStreetMap PBF sub-regions from country-level data using a bounding box.

## Requirements

- [Docker](https://www.docker.com/) and Docker Compose

## Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/trufi-association/trufi-pbf-extractor.git
   cd trufi-pbf-extractor
   ```

2. **Create your configuration**
   ```bash
   cp .env.example .env
   ```

3. **Edit `.env`** with your city's values (see Configuration section below)

4. **Run the extractor**
   ```bash
   docker-compose up --build
   ```

5. **Find your output** in `./data/<city_name>.osm.pbf`

## Configuration

Edit the `.env` file with these variables:

| Variable | Description | Example |
|----------|-------------|---------|
| `CITY_NAME` | Name for the output file | `kigali` |
| `BBOX` | Bounding box (west,south,east,north) | `29.979526,-2.079821,30.27987,-1.779581` |
| `GEOFABRIK_URL_PATH` | Path to country PBF on Geofabrik | `/africa/rwanda-latest.osm.pbf` |

### How to get the values

**Bounding Box:**
1. Go to [boundingbox.klokantech.com](https://boundingbox.klokantech.com/)
2. Navigate to your city and draw a box around the area you want
3. Select "CSV" format at the bottom
4. Copy the coordinates (format: west,south,east,north)

**Geofabrik URL Path:**
1. Go to [download.geofabrik.de](https://download.geofabrik.de/)
2. Navigate to your continent → country
3. Copy the path after `download.geofabrik.de` (e.g., `/africa/rwanda-latest.osm.pbf`)

## Example Configurations

### Kigali, Rwanda
```env
CITY_NAME=kigali
BBOX=29.979526,-2.079821,30.27987,-1.779581
GEOFABRIK_URL_PATH=/africa/rwanda-latest.osm.pbf
```

### Quito, Ecuador
```env
CITY_NAME=quito
BBOX=-78.669528,-0.416925,-77.958163,0.504543
GEOFABRIK_URL_PATH=/south-america/ecuador-latest.osm.pbf
```

### Cochabamba, Bolivia
```env
CITY_NAME=cochabamba
BBOX=-66.227,-17.478,-66.086,-17.329
GEOFABRIK_URL_PATH=/south-america/bolivia-latest.osm.pbf
```

## Output

The extracted PBF file will be saved to:
```
./data/<CITY_NAME>.osm.pbf
```

You can use this file with:
- [OpenTripPlanner](https://www.opentripplanner.org/) for transit routing
- [JOSM](https://josm.openstreetmap.de/) for viewing/editing
- Other OSM-compatible tools

## Troubleshooting

### Docker is not running
```bash
# Check if Docker is running
docker ps

# Start Docker Desktop or the Docker daemon
```

### Permission denied on data folder
```bash
# Create the data folder with proper permissions
mkdir -p data
chmod 755 data
```

### Download fails
- Check your internet connection
- Verify the Geofabrik URL path is correct at [download.geofabrik.de](https://download.geofabrik.de/)

### Empty or very small output file
- Verify your bounding box coordinates are correct
- Make sure west < east and south < north
- Check that your bbox is within the country boundaries

## How It Works

1. Downloads the country-level PBF from Geofabrik
2. Uses [osmium-tool](https://osmcode.org/osmium-tool/) to extract the specified bounding box
3. Saves the result to the mounted data volume

## License

MIT License - see [LICENSE](LICENSE) for details.

## Credits

- [Trufi Association](https://www.trufi-association.org/)
- [Geofabrik](https://www.geofabrik.de/) for OpenStreetMap extracts
- [osmium-tool](https://osmcode.org/osmium-tool/) for PBF processing
