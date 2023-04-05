enum StorageFolder {
  images('images'),
  videos('videos'),
  sounds('sounds');

  final String folderName;

  const StorageFolder(this.folderName);
}
